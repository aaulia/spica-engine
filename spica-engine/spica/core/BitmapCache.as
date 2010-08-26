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
		private static var _instance:BitmapCache = null;
		private static var guardFlag:Boolean     = false;
		
		private var cache:Dictionary = new Dictionary();
		
		public function BitmapCache()
		{
			if (!guardFlag)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
		}

		public static function get instance():BitmapCache
		{
			if (_instance == null)
			{
				guardFlag = true;
				_instance = new BitmapCache();
				guardFlag = false;
			}
			
			return _instance;
		}
		
		public function clear():void
		{
			for each(var id:String in cache)
			{
				var buffer:BitmapData = BitmapData(cache[ id ]);
				if (buffer)
					buffer.dispose();
				
				cache[ id ] = null;
				delete cache[ id ];
			}
			
			cache = new Dictionary(true);
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
		
	}

}
