package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import spica.core.Camera;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author ...
	 */
	public class BitmapText extends Visual
	{
		private const SPACE  :int          = -1;
		private const TAB    :int          = -2;
		private const NEWLINE:int          = -3;
		
		
		private var font     :Sprite       = null;
		private var charMap  :Object       = null;
		
		
		private var point    :Point        = null;
		private var index    :Vector.<int> = null;
		private var length   :int          = 0;
		
		
		private var _text    :String       = "";
		private var _width   :int          = 0;
		private var _height  :int          = 0;
		
		
		public function BitmapText(linkage:Class, width:int, height:int, dict:String)
		{
			super();
			
			font    = new Sprite(linkage, width, height);
			point   = new Point();
			index   = new Vector.<int>();
			charMap = new Object();
			
			for (var i:int = 0; i < dict.length; ++i)
				charMap[ dict.charAt(i) ] = i;
		
		}
		
		
		public function get text():String { return _text; }
		public function set text(v:String):void
		{
			if (_text == v)
				return;
				
			_text   = v;
			_width  = v.length * font.width;
			_height = font.height;
			length  = v.length;
			for (var i:int = 0; i < length; ++i)
			{
				var c:String = v.charAt(i);
				switch(c)
				{
					case " " : index[ i ] = SPACE;        break;
					case "\t": index[ i ] = TAB;          break;
					case "\n": index[ i ] = NEWLINE;      break;
					default  : index[ i ] = charMap[ c ]; break;
				}
			}
			
		}
		
		
		override public function get width ():int { return _width;  }
		override public function get height():int { return _height; }
		
		
		override public function render(context:RenderContext):void
		{
			var camera:Camera     = context.camera;
			var buffer:BitmapData = context.buffer;
			
			if (scroll != 0 && camera != null)
			{
				point.x = x - offsetX + int(0.5 + camera.offsetX * scroll);
				point.y = y - offsetY + int(0.5 + camera.offsetY * scroll);
			}
			else
			{
				point.x = x - offsetX;
				point.y = y - offsetY;
			}
			
			if (point.x < -_width  || point.x > buffer.width ||
			    point.y < -_height || point.y > buffer.height)
			{
				return;
			}
			
			font.x = point.x;
			font.y = point.y;
			for (var i:int = 0; i < length; ++i)
			{
				var c:int = index[ i ];
				switch(c)
				{
					case SPACE  : font.x += font.width;     break;
					case TAB    : font.x += font.width * 4; break;
					case NEWLINE:
					{
						font.y += font.height;
						font.x  = point.x;
						break;
					}
					
					default     :
					{
						if (c >= 0)
						{
							font.frame = c;
							font.render(render);
						}
						
						font.x += font.width;
						break;
					}
					
				}
				
			}
			
		}
		
	}

}
