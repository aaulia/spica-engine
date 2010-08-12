package spica.core
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class TimerManager
	{
		private var fps    :int          = 0;
		private var _elapse:int          = 0;
		private var current:int          = 0;
		private var samples:Vector.<int> = null;
		private var average:int          = 0;
		
		public function TimerManager(fps:int)
		{
			this.fps = fps;
			_elapse  = 0;
			current  = getTimer();
			samples  = new Vector.<int>(8, true);
			
			var ms:int = 1000 / fps;
			for (var i:int = 0; i < 8; ++i)
				samples[ i ] = ms;
				
		}
		
		public function get elapsed():Number
		{
			return average * 0.001;
		}
		
		public function update():void
		{
			_elapse = getTimer() - current;
			current = getTimer();
			average = 0;
			
			for (var i:int = 0; i < 8; ++i)
			{
				samples[ i ] = (i < 7 ? samples[ i + 1 ] : _elapse);
				average += samples[ i ];
			}
			
			average >>= 3;
		}
		
	}

}
