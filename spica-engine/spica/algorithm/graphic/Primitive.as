package spica.algorithm.graphic
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Primitive
	{
		public function line(buffer:BitmapData, x0:int, y0:int, x1:int, y1:int, color:uint):Primitive
		{
			if (buffer == null)
				throw "Destination buffer is invalid!";
			
			var shortLen:int     = y1 - y0;
			var longLen :int     = x1 - x0;
			var yLonger :Boolean = false;
			
			if ((shortLen ^ (shortLen >> 31)) - (shortLen >> 31) > (longLen ^ (longLen >> 31)) - (longLen >> 31))
			{
				shortLen ^= longLen;
				longLen  ^= shortLen;
				shortLen ^= longLen;
				
				yLonger   = true;
			}
			
			var inc     :int    = longLen  < 0 ? -1 : 1;
			var multDiff:Number = longLen == 0 ? shortLen : shortLen / longLen;
			var iter    :int    = 0;
			
			if (yLonger)
				for (iter = 0; iter != longLen; iter += inc)
					buffer.setPixel32(x0 + iter * multDiff, y0 + iter, color);
					
			else
				for (iter = 0; iter != longLen; iter += inc)
					buffer.setPixel32(x0 + iter, y0 + iter * multDiff, color);
					
					
			return this;
		}
		
		
		public function rect(buffer:BitmapData, x0:int, y0:int, x1:int, y1:int, color:uint):Primitive
		{
			if (buffer == null)
				throw "Destination buffer is invalid!";
				
			if (x0 > x1) { x0 ^= x1; x1 ^= x0; x0 ^= x1; }
			if (y0 > y1) { y0 ^= y1; y1 ^= y0; y0 ^= y1; }
			
			var r:Rectangle = new Rectangle(x0, y0, x1 - x0, 1);
			buffer.fillRect(r, color);
			
			r.y = y1;
			buffer.fillRect(r, color);
			
			r.y = y0; r.width = 1; r.height = (y1 - y0);
			buffer.fillRect(r, color);
			
			r.x = x1;
			buffer.fillRect(r, color);
			
			return this;
		}
		
		
		public function fillRect(buffer:BitmapData, x0:int, y0:int, x1:int, y1:int, color:uint):Primitive
		{
			if (buffer == null)
				throw "Destination buffer is invalid!";
				
			if (x0 > x1) { x0 ^= x1; x1 ^= x0; x0 ^= x1; }
			if (y0 > y1) { y0 ^= y1; y1 ^= y0; y0 ^= y1; }
			
			var r:Rectangle = new Rectangle(x0, y0, x1 - x0, y1 - y0);
			buffer.fillRect(r, color);
			
			return this;
		}
		
		
		public function poly(buffer:BitmapData, points:Vector.<int>, color:uint):Primitive
		{
			var length:int = points.length - 2;
			for (var i:int = 0; i < length; i += 2)
				line
					( buffer
					, points[ i ]
					, points[ i + 1 ]
					, points[ i + 2 ]
					, points[ i + 3 ]
					, color );
			
			return this;
		}
		
		
		public function circle(buffer:BitmapData, cx:int, cy:int, radius:int, color:uint):Primitive
		{
			if (buffer == null)
				throw "Destination buffer is invalid!";
				
			var x:int = 0;
			var y:int = radius < 0 ? -radius : radius;
			var d:int = 1 - y;
			
			buffer.setPixel32(cx + x, cy + y, color);
			buffer.setPixel32(cx + x, cy - y, color);
			buffer.setPixel32(cx - y, cy + x, color);
			buffer.setPixel32(cx + y, cy + x, color);
			
			var cxxp:int = 0; var cxxm:int = 0;
			var cxyp:int = 0; var cxym:int = 0;
			
			var cyyp:int = 0; var cyym:int = 0;
			var cyxp:int = 0; var cyxm:int = 0;
			
			while (y > x)
			{
				if (d < 0)
					d += (x + 3) << 1;
				else
				{
					d += ((x - y) << 1) + 5;
					y--;
				}
				
				++x;
				
				cxxp = cx + x; cxxm = cx - x;
				cxyp = cx + y; cxym = cx - y;
				
				cyyp = cy + y; cyym = cy - y;
				cyxp = cy + x; cyxm = cy - x;
				
				buffer.setPixel32(cxxp, cyyp, color);
				buffer.setPixel32(cxxm, cyyp, color);
				buffer.setPixel32(cxxp, cyym, color);
				buffer.setPixel32(cxxm, cyym, color);
				buffer.setPixel32(cxym, cyxp, color);
				buffer.setPixel32(cxym, cyxm, color);
				buffer.setPixel32(cxyp, cyxm, color);
				buffer.setPixel32(cxyp, cyxp, color);
			}
			
			return this;
		}
		
		
		public function fillCircle(buffer:BitmapData, cx:int, cy:int, radius:int, color:uint):Primitive
		{
			if (buffer == null)
				throw "Destination buffer is invalid!";
				
			var x:int       = 0;
			var y:int       = radius < 0 ? -radius : radius;
			var d:int       = 1 - y;
			var r:Rectangle = new Rectangle(0, 0, 1, 1);
			
			r.x             = cx;
			r.y             = cy - y;
			r.height        = y << 1;
			buffer.fillRect(r, color);
			
			while (y > x)
			{
				if (d < 0)
					d += (x + 3) << 1;
				else
				{
					d += ((x - y) << 1) + 5;
					y--;
				}
				
				++x;
				
				r.x      = cx + x;
				r.y      = cy - y;
				r.height =  y + y;
				buffer.fillRect(r, color);
				
				r.x      = cx - x;
				buffer.fillRect(r, color);
				
				r.x      = cx - y;
				r.y      = cy - x;
				r.height =  x + x;
				buffer.fillRect(r, color);
				
				r.x      = cx + y;
				buffer.fillRect(r, color);
			}
			
			return this;
		}
		
	}

}
