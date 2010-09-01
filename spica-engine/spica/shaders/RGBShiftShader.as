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
		public  var radius:int               = 2;
		
		
		private var rgbCh :BitmapData        = null;
		private var point :Point             = null;
		
		
		public function RGBShiftShader(width:int, height:int, radius:int = 2)
		{
			this.rgbCh  = new BitmapData(width, height, true, 0x00000000);
			this.point  = new Point();
			this.radius = radius;
		}
		
		
		override public function postRender(source:BitmapData):void
		{
			rgbCh.fillRect(rgbCh.rect, 0x00000000);
			point.x = point.y = 0;
			
			for (var i:int = 0; i < 3; ++i)
			{
				point.x = -radius + Math.random() * (radius << 1);
				point.y = -radius + Math.random() * (radius << 1);
				
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
