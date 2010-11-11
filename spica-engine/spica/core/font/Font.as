package spica.core.font
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.system.System;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Font
	{
		public var name  :String        = "";	/** read-only */
		public var buffer:BitmapData    = null;	/** read-only */
		public var height:int           = 0;	/** read-only */
		public var chars :/*Char*/Array = null;	/** read-only */
		
		
		public function Font(name:String, buffer:BitmapData, desc:XML)
		{
			this.buffer = buffer;
			this.height = int(desc.common.@lineHeight);
			this.chars  = [];
			
			var length:int = desc.chars.@count;
			for (var i:int = 0; i < length; ++i)
			{
				var char:XML = desc.chars.char[ i ];
				chars[ char.@id ] = new Char
					( new Rectangle(char.@x, char.@y, char.@width, char.@height)
					, char.@xoffset
					, char.@yoffset
					, char.@xadvance );
			}
			
			System.disposeXML(desc);
		}
		
		
		public function dispose():void
		{
			if (buffer) buffer.dispose();
			
			buffer = null;
			chars  = null;
		}

		
		public function getLineWidth(text:String):int
		{
			if (text == "")
				return 0;
				
			var result:int = 0;
			var length:int = text.length;
			for (var i:int = 0; i < length; ++i)
				result += chars[ text.charCodeAt(i) ].xAdv;
			
			return result;
		}
		
	}

}
