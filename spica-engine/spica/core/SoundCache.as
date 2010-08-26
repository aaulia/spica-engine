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
		

		
		private static var cache:Object = new Object();
		
		public function SoundCache()
		{
			if (!guardFlag)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
				
		}
		
		public function clearAll():void
		{
			cache = new Object();
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
