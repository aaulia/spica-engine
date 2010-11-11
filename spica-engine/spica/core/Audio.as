package spica.core
{
	import flash.display.DisplayObjectContainer;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class Audio
	{
		public function Audio()
		{
			
		}
		
		
		private var dev:SoundTransform = null;
		private var vol:Number         = 0;
		
		
		internal function initialize(parent:DisplayObjectContainer):void
		{
			dev = SoundMixer.soundTransform;
			vol = dev.volume
		}
				
		
		public function get volume():Number { return vol; }
		public function set volume(v:Number):void
		{
			if (vol != v)
			{
				if (v < 0) v = 0;
				if (v > 1) v = 1;
				
				dev.volume =
				vol        = v;
				
				SoundMixer.soundTransform = dev;
			}
			
		}
		
		
		public function get panning():int { return dev.pan; }
		public function set panning(v:int):void
		{
			var pan:Number = v * 0.01;
			if (dev.pan != pan)
			{
				if (pan < -1) pan = -1;
				if (pan >  1) pan =  1;
				
				dev.pan = pan;
				SoundMixer.soundTransform = dev;
			}
			
		}
		
		
		public function get muted():Boolean { return dev.volume == 0; }
		public function set muted(v:Boolean):void
		{
			dev.volume = (v ? 0 : vol);
			SoundMixer.soundTransform = dev;
		}
		
	}

}
