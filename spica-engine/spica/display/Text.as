package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import spica.core.Camera;
	import spica.core.font.Char;
	import spica.core.font.Font;
	import spica.core.FontCache;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Text extends Visual
	{
		private var v_text:String = "";
		public function get text():String { return v_text; }
		public function set text(v:String):void
		{
			if (v_text != v)
			{
				dirty  = true;
				v_text = v;
				calcSize();
			}
			
		}
		
		private var v_font:Font = FontCache.getFont("default");
		public function get font():String { return v_font.name; }
		public function set font(v:String):void
		{
			if (v == "")
				v = "default";
				
			if (v != v_font.name)
			{
				dirty  = true;
				v_font = FontCache.getFont(v);
				calcSize();
			}
				
		}
		
		
		private var buffer:BitmapData = null;
		private var point :Point      = new Point();
		private var dirty :Boolean    = false;
		
		
		public function Text(text:String = "", font:String = "default")
		{
			this.font = font;
			this.text = text;
		}
		
		
		private function refresh():void
		{
			dirty = false;
			
			if (v_text == "")
			{
				if (buffer)
				{
					buffer.dispose();
					buffer = null;
				}
				
				return;
			}
			
			if (buffer)
			{
				if (buffer.width != width || buffer.height != height)
				{
					buffer.dispose();
					buffer = new BitmapData(width, height, true, 0x00000000);
				}
				else
					buffer.fillRect(buffer.rect, 0x00000000);
			}
			else
				buffer = new BitmapData(width, height, true, 0x00000000);
				
			
			var lines :Array = v_text.split("\n");
			var pos   :Point = new Point();
			var length:int   = lines.length;
			
			for (var i:int = 0; i < length; ++i)
			{
				pos.x = 0;
				pos.y = i * v_font.height;
				
				var char :Char   = null;
				var line :String = lines[ i ];
				var count:int    = line.length;
				
				for (var j:int = 0; j < count; ++j)
				{
					char   = v_font.chars[ line.charCodeAt(j) ];
					
					pos.x += char.xOff;
					pos.y += char.yOff;

					buffer.copyPixels
						( v_font.buffer
						, char.rect
						, pos
						, null
						, null
						, true );
						
					pos.x += (char.xAdv - char.xOff);
					pos.y -= char.yOff;
				}
				
			}
			
		}
		
		
		private function calcSize():void
		{
			width  = 0;
			height = 0;
			
			var lines :Array = v_text.split("\n");
			var length:int = lines.length;
			
			for (var i:int = 0; i < length; ++i)
			{
				var lineWidth:int = v_font.getLineWidth(lines[ i ]);
				if (width < lineWidth)
					width = lineWidth;
					
			}
		
			height = length * v_font.height;
		}
		
		
		
		override public function render(context:RenderContext):void
		{
			if (dirty  == true) refresh();
			if (v_text ==   "") return;
			
			var scr:BitmapData = context.buffer;
			var cam:Camera     = context.camera;
			
			if (scr == null)
				return;

			calcRenderPos(cam, point);
			
			if (point.x < -width || point.y < -height || point.x > scr.width || point.y > scr.height)
				return;
				
			scr.copyPixels(buffer, buffer.rect, point, null, null, true);
		}
		
		
		override public function dispose():void
		{
			if (buffer)
				buffer.dispose();
				
			point  = null;
			buffer = null;
			v_font = null;
		}
		
	}

}
