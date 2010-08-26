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
		private static var _instance:SoundCache = null;
		private static var guardFlag:Boolean    = false;
		
		private static var cache:Dictionary = new Dictionary();
		
		public function SoundCache()
		{
			if (!guardFlag)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
				
		}
		
		public static function get instance():SoundCache
		{
			if (_instance == null)
			{
				guardFlag = true;
				_instance = new SoundCache();
				guardFlag = false;
			}
			
			return _instance;
		}
		
		public function clearAll():void
		{
			for each(var id:String in cache)
			{
				cache[ id ] = null;
				delete cache[ id ];
			}
			
			cache = new Dictionary(true);
		}
		
		public function getSound(linkage:Class):Sound
		{
			var id:String = String(linkage);
			if (cache[ id ] != null)
				return cache[ id ];
				
			return (cache[ id ] = Sound(new linkage()));
		}
		
	}

}
