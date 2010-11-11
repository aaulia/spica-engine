package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedSuperclassName;
	import spica.core.font.Font;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class FontCache
	{
		private static var cache:Object = new Object();
		
		
		public static function regFont(name:String, asset:Class, desc:Class):void
		{
			if (name == "" || asset == null || desc == null)
				return;
				
			if (cache[ name ] != null)
				cache[ name ].dispose();
				
			var bmd:BitmapData  = null;
			var ancestor:String = getQualifiedSuperclassName(asset);
			
			(ancestor.indexOf("BitmapData") >= 0)
				? bmd = (new asset(0, 0)) as BitmapData
				: bmd = (new asset() as Bitmap).bitmapData;
			
			var ba :ByteArray   = new desc();
			var xml:XML         = new XML(ba.readUTFBytes(ba.length));
			
			cache[ name ]       = new Font(name, bmd, xml);
		}
		
		
		public static function getFont(name:String):Font
		{
			return name == ""
				? null
				: cache[ name ];
		}
		
		
		public static function clear():void
		{
			for each (var fnt:Font in cache)
				fnt.dispose();
			
			cache = null;
		}
		
	}

}
