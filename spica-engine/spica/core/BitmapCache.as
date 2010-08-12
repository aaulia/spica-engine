package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class BitmapCache
	{
		private static var cache:Dictionary = null;

		public static function clear():void
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
		
		public static function getBitmap(linkage:Class):BitmapData
		{
			if (cache == null)
				cache = new Dictionary();
			
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
