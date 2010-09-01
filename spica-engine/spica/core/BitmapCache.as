package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class BitmapCache
	{
		private var cache:Object = new Object();
		
		
		public function BitmapCache(lock:Class)
		{
			if (lock != SingletonLock)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
				
		}

		
		public function clear():void
		{
			for each(var bitmapData:BitmapData in cache)
				if (bitmapData != null)
					bitmapData.dispose();
			
			cache = new Object();
		}
		
		
		public function getBitmap(linkage:Class):BitmapData
		{
			var id:String = String(linkage);
			if (cache[ id ] != null)
				return cache[ id ];
				
			var ancestor:String = getQualifiedSuperclassName(linkage);
			if (ancestor.indexOf("BitmapData") >= 0)
				cache[ id ] = new linkage(0, 0) as BitmapData;
			else
				cache[ id ] = (new linkage() as Bitmap).bitmapData;
				
			return cache[ id ];
		}

		
		
		private static var _instance:BitmapCache = new BitmapCache(SingletonLock);
		public static function get instance():BitmapCache 
		{
			return _instance; 
		}
		
	}

}

class SingletonLock { }
