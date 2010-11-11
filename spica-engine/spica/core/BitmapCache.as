package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class BitmapCache
	{
		private static var cache:Object = new Object();

		
		public static function isExist(id:String):Boolean
		{
			return cache[ id ] != null;
		}
		
		
		public static function create(width:int, height:int, id:String = ""):BitmapData
		{
			if (id == "")
				id = width + "x" + height;

			if (cache[ id ] != null)
				return cache[ id ];
				
			return cache[ id ] = new BitmapData(width, height, true, 0x00000000);
		}
		
		
		public static function getBitmap(id:String):BitmapData
		{
			return id != ""
				? cache[ id ]
				: null;
		}
		
		
		public static function getBitmapByClass(asset:Class):BitmapData
		{
			if (asset == null)
				return null;
			
			var id:String = String(asset);
			if (cache[ id ] != null)
				return cache[ id ];
				
			var ancestor:String = getQualifiedSuperclassName(asset);
			if (ancestor.indexOf("BitmapData") >= 0)
				cache[ id ] = (new asset(0, 0) as BitmapData);
			else
				cache[ id ] = (new asset() as Bitmap).bitmapData;
				
			return cache[ id ];
		}

		
		public static function clear():void
		{
			for each(var bitmapData:BitmapData in cache)
				if (bitmapData != null)
					bitmapData.dispose();
			
			cache = new Object();
		}
		
	}

}
