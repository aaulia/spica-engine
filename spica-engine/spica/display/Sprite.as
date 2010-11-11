package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spica.core.BitmapCache;
	import spica.core.Camera;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Sprite extends Visual
	{
		public    var frameCount:int                = 0; /** read-only */
		public    var frame     :int                = 0;
		
		
		protected var buffer    :BitmapData         = null;
		protected var frames    :Vector.<Rectangle> = null;
		protected var point     :Point              = new Point();
		
		
		public function Sprite(asset:Class = null, w:int = 0, h:int = 0)
		{
			load(asset, w, h);
		}
		
		public function load(asset:Class, w:int = 0, h:int = 0):void
		{
			if (asset == null)
				return;
			
			buffer     = BitmapCache.getBitmapByClass(asset);
			frames     = new Vector.<Rectangle>();
			frame      = 0;
			frameCount = 0
			
			if (w == 0) w = buffer.width;
			if (h == 0) h = buffer.height;
			
			var r:int  = int(buffer.height / h);
			var c:int  = int(buffer.width  / w);
			for (var j:int = 0; j < r; ++j)
				for (var i:int = 0; i < c; ++i)
					frames[ frameCount++ ] = new Rectangle(i * w, j * h, w, h);
			
			
			width      = w;
			height     = h;
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
				
			scr.copyPixels(buffer, frames[ frame ], point, null, null, true);
		}
		
		override public function dispose():void
		{
			buffer = null;
			frames = null;
			point  = null;
		}
		
	}

}
