package spica.audio
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import spica.core.SoundCache;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Music
	{
		private var sound    :Sound          = null;
		private var channel  :SoundChannel   = null;
		private var transform:SoundTransform = null;
		private var position :int            = 0;
		
		public function get isPlaying():Boolean { return channel != null; }
		
		public function get volume():Number { return transform.volume; }
		public function set volume(v:Number):void
		{
			if (transform.volume != v)
			{
				transform.volume = v;
				if (channel != null)
					channel.soundTransform = transform;
					
			}
			
		}
		
		public function get pan():Number { return transform.pan; }
		public function set pan(v:Number):void
		{
			if (transform.pan != v)
			{
				transform.pan = v;
				if (channel != null)
					channel.soundTransform = transform;
					
			}
			
		}
		
		
		public function Music(linkage:Class)
		{
			sound     = SoundCache.getSound(linkage);
			channel   = null;
			transform = new SoundTransform();
			position  = 0;
		}
		
		public function loadMusic(linkage:Class):Music
		{
			if (channel != null)
				channel.stop();
				
			sound     = SoundCache.getSound(linkage);
			channel   = null;
			position  = 0;
			
			return this;
		}
		
		public function play(reset:Boolean = true):void
		{
			if (channel != null)
			{
				if (reset)
				{
					stop();
					channel = sound.play(position, 0, transform);
					channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				}
				
			}
			else
			{
				channel = sound.play(position, 0, transform);
				channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			
		}
		
		private function onSoundComplete(e:Event):void
		{
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			position = 0;
			channel  = sound.play(position, 0, transform);
			
			channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		public function stop():void
		{
			if (channel != null)
			{
				channel.stop();
				channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				channel = null;
			}
			
			position = 0;
		}
		
		public function pause():void
		{
			if (channel != null)
			{
				position = channel.position;
				
				channel.stop();
				channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				channel = null;
			}
			
		}
		
	}

}
