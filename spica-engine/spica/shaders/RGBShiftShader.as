package spica.shaders
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import spica.core.Shader;
	import spica.math.ParkMillerRandom;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class RGBShiftShader extends Shader
	{
		private var rgbCh :BitmapData        = null;
		private var point :Point             = null;
		
		public function RGBShiftShader(width:int, height:int)
		{
			rgbCh  = new BitmapData(width, height, true, 0x00000000);
			point  = new Point();
		}
		
		override public function postRender(source:BitmapData):void
		{
			rgbCh.fillRect(rgbCh.rect, 0x00000000);
			point.x = point.y = 0;
			
			for (var i:int = 0; i < 3; ++i)
			{
				point.x = -5 + Math.random() * 10;
				point.y = -5 + Math.random() * 10;
				
				rgbCh.copyChannel(source, source.rect, point, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
				rgbCh.copyChannel(source, source.rect, point, 1 << i, 1 << i);
			}
			
			point.x = point.y = 0;
			source.copyPixels(rgbCh, rgbCh.rect, point);
		}
		
		override public function shutdown():void
		{
			rgbCh.dispose();
			
			rgbCh = null;
			point = null;
		}
	}

}
