package spica.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import spica.core.BitmapCache;
	import spica.core.Camera;
	import spica.core.RenderContext;
	import spica.math.TrigLookUp;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class SpriteRot extends Sprite
	{
		public  var rotation:int    = 0;
		
		
		private var stepDeg :int    = 6;
		private var stepRad :Number = stepDeg * TrigLookUp.DEG_TO_RAD;
		private var stepIter:int    = int(360 / stepDeg + 0.5);
		
		
		public function SpriteRot(asset:Class = null, w:int = 0, h:int = 0, step:int = 6)
		{
			stepDeg = step;
			super(asset, w, h);
		}
		
		
		public function loadRotated(asset:Class, w:int, h:int, step:int):void
		{
			stepDeg = step;
			load(asset, w, h);
		}
		
		
		override public function load(asset:Class, w:int = 0, h:int = 0):void
		{
			if (asset == null)
				return;

			stepRad     = stepDeg * TrigLookUp.DEG_TO_RAD
			stepIter    = int((360 / stepDeg) + 0.5);
			
			var oriBuf:BitmapData = BitmapCache.getBitmapByClass(asset);
			
			width       = (w == 0) ? oriBuf.width  : w;
			height      = (h == 0) ? oriBuf.height : h;
			
			var col:int = int(oriBuf.width  / width);
			var row:int = int(oriBuf.height / height);
			
			frameCount  = row * col;
			frame       = 0;
			frames      = new Vector.<Rectangle>();
			
			for (var i:int = 0; i < stepIter; ++i)
				for (var j:int = 0; j < row; ++j)
					for (var k:int = 0; k < col; ++k)
						frames[ frames.length ] = new Rectangle
							( k * width
							, j * height + i * oriBuf.height
							, width
							, height );
							
						
			var id:String = String(asset) + "_ROT_" + stepIter;
			if (!BitmapCache.isExist(id))
			{
				var rotMat:Matrix     = new Matrix();
				var rotFrm:BitmapData = new BitmapData(width, height, true, 0x00000000);
				var rotBuf:BitmapData = BitmapCache.create
					( oriBuf.width
					, oriBuf.height * stepIter
					, id );

				var hw:int = width  * 0.5;
				var hh:int = height * 0.5;
				
				point.x = 0
				point.y = 0;
				
				rotBuf.fillRect(rotBuf.rect, 0x00000000);
				
				for (j = 0; j < row; ++j)
				{
					var th:int = hh + j * height;
					for (k = 0; k < col; ++k)
					{
						var fi:int = k + j * col;
						rotFrm.copyPixels
							( oriBuf
							, frames[ fi ]
							, point
							, null
							, null
							, false );
						
						var tw:int = hw + k * width;
						for (i = 0; i < stepIter; ++i)
						{
							rotMat.identity();
							rotMat.translate(-hw, -hh);
							rotMat.rotate(i * -stepRad);
							rotMat.translate(tw, th + (i * oriBuf.height));
							rotBuf.draw(rotFrm, rotMat, null, null, null, true);
						}
						
					}
					
				}
			
				rotFrm.dispose();
				buffer = rotBuf;
			}
			else
				buffer = BitmapCache.getBitmap(id);
			
		}
		
		
		override public function render(context:RenderContext):void
		{
			var scr:BitmapData = context.buffer;
			var cam:Camera     = context.camera;
			
			if (scr == null)
				return;

			calcRenderPos(cam, point);
			
			if (point.x < -width || point.y < -height || point.x > scr.width || point.y > scr.height)
				return;
				
			var index:int = int((rotation % 360) / stepDeg) * frameCount;
			scr.copyPixels(buffer, frames[ frame + index ], point, null, null, true);
		}
		
	}

}
