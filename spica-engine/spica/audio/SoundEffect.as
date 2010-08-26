package spica.audio
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import spica.core.SoundCache;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class SoundEffect
	{
		private var sound   :Sound    = null;
		private var onFinish:Function = null;
		
		public function SoundEffect(linkage:Class)
		{
			loadSound(linkage);
		}
		
		public function loadSound(linkage:Class):SoundEffect
		{
			sound = SoundCache.instance.getSound(linkage);
			return this;
		}
		
		public function play(onFinish:Function = null):void
		{
			this.onFinish = onFinish;
			sound.play()
			     .addEventListener(Event.SOUND_COMPLETE, onSoundFinish);
		}
		
		private function onSoundFinish(e:Event):void
		{
			if (onFinish != null)
				onFinish();
				
			onFinish = null;
			(e.target as SoundChannel)
				.removeEventListener(Event.SOUND_COMPLETE, onSoundFinish);
		}
		
	}

}
