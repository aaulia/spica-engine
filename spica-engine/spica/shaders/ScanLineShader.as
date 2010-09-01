package spica.shaders
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import spica.core.Shader;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class ScanLineShader extends Shader
	{
		private const DEFAULT_PATTERN:Array = [ [0.5, 0.5], [0, 0] ];
		
		
		private var scanBuffer:BitmapData = null;
		private var pattBuffer:BitmapData = null;
		private var point     :Point      = null;
		
		
		public function ScanLineShader(width:int, height:int, pattern:Array = null)
		{
			if (pattern == null)
				pattern = DEFAULT_PATTERN;
			
			var h:int  = pattern     .length;
			var w:int  = pattern[ 0 ].length;
			pattBuffer = new BitmapData(w, h, true, 0x00000000);
			point      = new Point();
			
			for (var i:int = 0; i < h; ++i)
				for (var j:int = 0; j < w; ++j)
					if (pattern[ i ][ j ] > 0)
						pattBuffer.setPixel32(j, i, (pattern[ i ][ j ] * 255) << 24);
						
			scanBuffer = new BitmapData(width, height, true, 0x00000000);
			for (i = 0; i < height; i += h)
			{
				point.y = i;
				for (j = 0; j < width; j += w)
				{
					point.x = j;
					scanBuffer.copyPixels(pattBuffer, pattBuffer.rect, point, null, null, true);
				}
				
			}
			
		}
		
		
		override public function postRender(source:BitmapData):void
		{
			point.x = point.y = 0;
			source.copyPixels(scanBuffer, scanBuffer.rect, point, null, null, true);
		}
		
		
		override public function shutdown():void
		{
			scanBuffer.dispose();
			pattBuffer.dispose();
			
			scanBuffer = null;
			pattBuffer = null;
			point      = null;
		}
		
	}

}
