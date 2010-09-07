package spica.math
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author
	 */
	public final class MathRNG
	{
		private const MAX_RATIO:Number = 1 / uint.MAX_VALUE;
		private var   seed     :uint   = Math.random() * uint.MAX_VALUE;
		
		
		public function MathRNG(lock:Class)
		{
			if (lock != SingletonLock)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
			
		}
		
		
		public function random():Number
		{
			seed ^= (seed << 21);
			seed ^= (seed >>> 35);
			seed ^= (seed << 4);
			return seed * MAX_RATIO;
		}
		
		
		private static const _instance:MathRND = new MathRND(SingletonLock)
		public static function get instance():MathRND
		{
			return _instance;
		}
		
	}

}

class SingletonLock { }
