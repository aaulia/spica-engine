package spica.core
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class TimerManager
	{
		private const SAMPLE_COUNT:int   = 8;
		private const SAMPLE_INDEX:int   = SAMPLE_COUNT - 1;
		
		
		private var fps    :int          = 0;
		private var elapse :int          = 0;
		private var current:int          = 0;
		private var samples:Vector.<int> = null;
		private var average:int          = 0;
		
		
		public function TimerManager(fps:int)
		{
			this.fps = fps;
			elapse   = 0;
			current  = getTimer();
			samples  = new Vector.<int>(SAMPLE_COUNT, true);
			
			var ms:int = int(1000.0 / fps + 0.5);
			for (var i:int = 0; i < SAMPLE_COUNT; ++i)
				samples[ i ] = ms;
				
		}
		
		
		public function get elapsed():Number
		{
			return average * 0.001;
		}
		
		
		public function update():void
		{
			elapse  = getTimer() - current;
			current = getTimer();
			average = 0;
			
			for (var i:int = 0; i < SAMPLE_COUNT; ++i)
			{
				samples[ i ] = (i < SAMPLE_INDEX ? samples[ i + 1 ] : elapse);
				average += samples[ i ];
			}
			
			average >>= 3;
		}
		
	}

}
