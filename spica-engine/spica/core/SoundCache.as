package spica.core
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class SoundCache
	{
		private static var cache:Dictionary = null;
		
		public static function clearAll():void
		{
			for each(var id:String in cache)
			{
				cache[ id ] = null;
				delete cache[ id ];
			}
			
			cache = new Dictionary(true);
		}
		
		public static function getSound(linkage:Class):Sound
		{
			if (cache == null)
				cache = new Dictionary();
			
			var id:String = String(linkage);
			if (cache[ id ] != null)
				return cache[ id ];
				
			return (cache[ id ] = Sound(new linkage()));
		}
		
	}

}
