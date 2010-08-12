package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spica.core.BitmapCache;
	import spica.core.Camera;
	import spica.core.Entity;
	import spica.core.RenderContext;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Sprite extends Entity
	{
		public  var x      :int                = 0;
		public  var y      :int                = 0;
		
		public  var scroll :Number             = 1.0;
		public  var offsetX:int                = 0;
		public  var offsetY:int                = 0;
		
		private var _frame :int                = -1;
		private var _height:int                = -1;
		private var _width :int                = -1;
		
		private var bitmap :BitmapData         = null;
		private var frames :Vector.<Rectangle> = null;
		private var point  :Point              = new Point();
		
		public function Sprite(linkage:Class, width:int = 0, height:int = 0)
		{
			loadBitmap(linkage, width, height);
		}
		
		public function loadBitmap(linkage:Class, width:int, height:int):Sprite
		{
			bitmap = BitmapCache.getBitmap(linkage);
			frames = new Vector.<Rectangle>();
			
			if (width  == 0) width  = bitmap.width;
			if (height == 0) height = bitmap.height;
			
			for (var i:int = 0; i < bitmap.height; i += height)
				for (var j:int = 0; j < bitmap.width; j += width)
					frames.push(new Rectangle(j, i, width, height));
					
			_frame  = 0;
			_width  = width;
			_height = height;
			
			return this;
		}
		
		public function get width()     :int  { return _width; }
		public function get height()    :int  { return _height; }
		public function get frameCount():int  { return frames.length; }
		public function get frame()     :int  { return _frame; }
		
		public function set frame(f:int):void
		{
			_frame = f % frames.length;
		}
		
		override public function render(render:RenderContext):void
		{
			var camera:Camera     = render.camera;
			var buffer:BitmapData = render.buffer;
			
			if (scroll != 0 && camera != null)
			{
				point.x = int(x + 0.5 - camera.offsetX * scroll) - offsetX;
				point.y = int(y + 0.5 - camera.offsetY * scroll) - offsetY;
			}
			else
			{
				point.x = int(x + 0.5) - offsetX;
				point.y = int(y + 0.5) - offsetY;
			}
			
			if (point.x < -_width  || point.x > buffer.width ||
			    point.y < -_height || point.y > buffer.height)
			{
				return;
			}
			
			buffer.copyPixels(bitmap, frames[ _frame ], point, null, null, true);
		}
		
		override public function shutdown():void
		{
			bitmap = null;
			frames = null;
			point  = null;
		}
		
	}

}