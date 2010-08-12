package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class VideoDriver
	{
		private var _stage :Stage      = null;
		private var _width :int        = 0;
		private var _height:int        = 0;
		private var _fps   :int        = 0;
		private var _bitmap:Bitmap     = null;
		private var _buffer:BitmapData = null;
		
		public function VideoDriver(stage:Stage, width:int, height:int, fps:int)
		{
			this._stage  = stage;
			this._width  = width;
			this._height = height;
			this._fps    = fps;
		}
		
		public function get stage() :Stage { return _stage; }
		public function get width() :int   { return _width; }
		public function get height():int   { return _height; }
		public function get fps()   :int   { return _fps; }
		public function get buffer():BitmapData { return _buffer; }
		public function get bitmap():Bitmap     { return _bitmap; }
		
		public function set fps(value:int):void
		{
			if (_fps != value)
				_fps  = _stage.frameRate = value;
		}
				
		internal function initiate():void
		{
			_stage.displayState = StageDisplayState.NORMAL;
			_stage.align        = StageAlign.TOP_LEFT;
			_stage.quality      = StageQuality.MEDIUM;
			_stage.scaleMode    = StageScaleMode.NO_SCALE;
			_stage.frameRate    = fps;
			
			_buffer = new BitmapData(width, height, true, 0x0);
			_bitmap = new Bitmap(_buffer, PixelSnapping.NEVER, false);

			_stage.addChild(_bitmap);
		}
		
		internal function shutdown():void
		{
			if (null != _bitmap.parent)
				_bitmap.parent.removeChild(_bitmap);
				
			_buffer.dispose();
			
			_bitmap = null;
			_buffer = null;
			_stage  = null;
		}
		
	}

}
