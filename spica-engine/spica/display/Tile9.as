package spica.display
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spica.core.BitmapCache;
	import spica.core.Camera;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 *
	 */
	public class Tile9 extends Visual
	{
		protected var skins   :Vector.<BitmapData> = null;
		protected var buffer  :BitmapData          = null;
		protected var point   :Point               = new Point();
		
		
		protected var o_width :int                 = 0;
		protected var o_height:int                 = 0;
		protected var dirty   :Boolean             = false;
		
		
		protected var gridW   :Vector.<int>        = null;
		protected var gridH   :Vector.<int>        = null;
		
		
		protected var shape   :Shape               = new Shape();
		protected var graphic :Graphics            = shape.graphics;
		protected var matrix  :Matrix              = new Matrix();
		
		
		public function Tile9(skin:Class, rect:Rectangle)
		{
			setSkin(skin, rect);
		}
		
		
		public function setSkin(skin:Class, rect:Rectangle):void
		{
			dirty = true;
			
			var src:BitmapData = BitmapCache.getBitmapByClass(skin);
			var srw:int        = src.width;
			var srh:int        = src.height;
			
			
			var x0:int = 0, x1:int = rect.x, x2:int = x1 + rect.width;
			var y0:int = 0, y1:int = rect.y, y2:int = y1 + rect.height;
			
			var gridX:Vector.<int> = Vector.<int>([ x0, x1, x2 ]);
			var gridY:Vector.<int> = Vector.<int>([ y0, y1, y2 ]);
			
			
			var w0:int = rect.x, w1:int = rect.width , w2:int = srw - w0 - w1;
			var h0:int = rect.y, h1:int = rect.height, h2:int = srh - h0 - h1;
			
			gridW      = Vector.<int>([ w0, w1, w2 ]);
			gridH      = Vector.<int>([ h0, h1, h2 ]);

			
			if (skins)
				for (var k:int = 0; k < 9; ++k)
					skins[ k ].dispose();
			else
				skins = new Vector.<BitmapData>();
				
					
			var clip :Rectangle = new Rectangle();
			var pos  :Point     = new Point();
			var index:int       = 0;
			
			for (var j:int = 0; j < 3; ++j)
			{
				clip.y      = gridY[ j ];
				clip.height = gridH[ j ];
				
				for (var i:int = 0; i < 3; ++i)
				{
					clip.x     = gridX[ i ];
					clip.width = gridW[ i ];
					
					skins[ index ] = new BitmapData(gridW[ i ], gridH[ j ]);
					skins[ index ].copyPixels(src, clip, pos);
					++index;
				}
				
			}
			
		}
		
		
		protected function refresh():void
		{
			if (width  < 0) width  = 0;
			if (height < 0) height = 0;
			
			o_width  = width;
			o_height = height;
			dirty    = false;
			
			if (width == 0 || height == 0)
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
				
			
			var mw:int          = width  - gridW[ 0 ] - gridW[ 2 ];
			var mh:int          = height - gridH[ 0 ] - gridH[ 2 ];
			
			var px:Vector.<int> = Vector.<int>([ 0, gridW[ 0 ], gridW[ 0 ] + mw ]);
			var py:Vector.<int> = Vector.<int>([ 0, gridH[ 0 ], gridH[ 0 ] + mh ]);
			
			var pw:Vector.<int> = Vector.<int>([ gridW[ 0 ], mw, gridW[ 2 ] ]);
			var ph:Vector.<int> = Vector.<int>([ gridH[ 0 ], mh, gridH[ 2 ] ]);
			
			for (var j:int = 0; j < 3; ++j)
			{
				matrix.ty = py[ j ];
				for (var i:int = 0; i < 3; ++i)
				{
					matrix.tx = px[ i ];
					
					graphic.beginBitmapFill(skins[ i + j * 3 ], matrix);
					graphic.drawRect(px[ i ], py[ j ], pw[ i ], ph[ j ]);
				}
				
			}
			
			graphic.endFill();
			
			buffer.draw(shape);
			graphic.clear();
		}
		
		
		override public function render(context:RenderContext):void
		{
			if (width != o_width || height != o_height || dirty)
				refresh();
				
			if (width == 0 || height == 0)
				return;
				
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
			
			if (skins)
				for (var i:int = 0; i < 9; ++i)
					skins[ i ].dispose();
				
			buffer  = null;
			skins   = null;
			point   = null;
			
			gridW   = null;
			gridH   = null;
			
			shape   = null;
			graphic = null;
			matrix  = null;
		}
		
	}

}
