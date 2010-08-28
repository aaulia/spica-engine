package spica.core
{
	import flash.errors.IllegalOperationError;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class SoundCache
	{
		private static var cache:Object = new Object();
		
		public function SoundCache(lock:SingletonLock)
		{
			if (lock != SingletonLock)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
				
		}
		
		public function getSound(linkage:Class):Sound
		{
			var id:String = String(linkage);
			if (cache[ id ] != null)
				return cache[ id ];
				
			return (cache[ id ] = Sound(new linkage()));
		}

		
		
		private static const _instance:SoundCache = new SoundCache(SingletonLock);
		public static function get instance():SoundCache { return _instance; }
		
	}

}

class SingletonLock { }
