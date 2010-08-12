package spica.core
{
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class AudioDriver
	{
		private var device :SoundTransform = null;
		private var _volume:Number         = 0;
		
		internal function initiate():void
		{
			device  = SoundMixer.soundTransform;
			_volume = device.volume
		}
		
		internal function shutdown():void
		{
			device  = null;
			_volume = 0;
		}
		
		public function get volume():Number { return _volume; }
		public function set volume(v:Number):void
		{
			if (_volume != v)
			{
				if (v < 0) v = 0;
				if (v > 1) v = 1;
				
				device.volume = _volume = v;
				SoundMixer.soundTransform = device;
			}
			
		}
		
		public function get panning():int { return device.pan; }
		public function set panning(v:int):void
		{
			var pan:Number = v * 0.01;
			if (device.pan != pan)
			{
				if (pan < -1) pan = -1;
				if (pan >  1) pan =  1;
				
				device.pan = pan;
				SoundMixer.soundTransform = device;
			}
			
		}
		
		public function get muted():Boolean { return device.volume == 0; }
		public function set muted(v:Boolean):void
		{
			device.volume = (v ? 0 : _volume);
			SoundMixer.soundTransform = device;
		}
		
	}

}
