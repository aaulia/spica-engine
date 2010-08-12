package spica.shaders
{
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spica.core.Shader;
	import spica.math.ParkMillerRandom;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class StaticDistortionShader extends Shader
	{
		private var buffer:BitmapData            = null;
		private var point :Point                 = null;
		private var filter:DisplacementMapFilter = null;
		private var random:ParkMillerRandom      = null;
		
		public function StaticDistortionShader(width:int, height:int)
		{
			point  = new Point();
			random = new ParkMillerRandom();
			buffer = new BitmapData(width, height, true, 0x0);
			for (var i:int = 0; i < height; ++i)
			{
				var c:int = random.random() * 256;
				buffer.fillRect(new Rectangle(0, i, width, 1), c << 16 | 255 << 24);
			}
			
			filter = new DisplacementMapFilter(buffer, point, 1, 0, 5, 0);
		}
		
		public function refresh():void
		{
			if (isActive == false)
				return;
				
			filter.scaleX = random.random() * 10;
		}
		
		override public function postRender(source:BitmapData):void
		{
			source.applyFilter(source, source.rect, point, filter);
		}
		
		override public function shutdown():void
		{
			buffer.dispose();
			
			buffer = null;
			filter = null;
			point  = null;
		}
		
	}

}
