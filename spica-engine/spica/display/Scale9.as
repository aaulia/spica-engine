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
	public class Scale9 extends Tile9
	{
		
		public function Scale9(skin:Class, rect:Rectangle)
		{
			super(skin, rect);
		}
		
		
		override protected function refresh():void
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
				
			
			var mw:int             = width  - gridW[ 0 ] - gridW[ 2 ];
			var mh:int             = height - gridH[ 0 ] - gridH[ 2 ];
			
			var px:Vector.<int>    = Vector.<int>([ 0, gridW[ 0 ], gridW[ 0 ] + mw ]);
			var py:Vector.<int>    = Vector.<int>([ 0, gridH[ 0 ], gridH[ 0 ] + mh ]);
			
			var pw:Vector.<int>    = Vector.<int>([ gridW[ 0 ], mw, gridW[ 2 ] ]);
			var ph:Vector.<int>    = Vector.<int>([ gridH[ 0 ], mh, gridH[ 2 ] ]);
			
			var sx:Vector.<Number> = Vector.<Number>([ pw[ 0 ] / gridW[ 0 ], pw[ 1 ] / gridW[ 1 ], pw[ 2 ] / gridW[ 2 ] ]);
			var sy:Vector.<Number> = Vector.<Number>([ ph[ 0 ] / gridH[ 0 ], ph[ 1 ] / gridH[ 1 ], ph[ 2 ] / gridH[ 2 ] ]);
			
			for (var j:int = 0; j < 3; ++j)
			{
				matrix.d  = sy[ j ];
				matrix.ty = py[ j ];
				for (var i:int = 0; i < 3; ++i)
				{
					matrix.a  = sx[ i ];
					matrix.tx = px[ i ];
					
					graphic.beginBitmapFill(skins[ i + j * 3 ], matrix);
					graphic.drawRect(px[ i ], py[ j ], pw[ i ], ph[ j ]);
				}
				
			}
			
			graphic.endFill();
			
			buffer.draw(shape);
			graphic.clear();
		}
		
	}

}
