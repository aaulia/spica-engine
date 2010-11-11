package spica.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
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
	public final class Video
	{
		public var parent   :DisplayObjectContainer = null; /** read-only */
		public var buffer   :BitmapData             = null; /** read-only */
		public var bitmap   :Bitmap                 = null; /** read-only */
		public var width    :int                    = 0;    /** read-only */
		public var height   :int                    = 0;    /** read-only */
		public var scale    :int                    = 0;    /** read-only */
		public var frameRate:int                    = 0;    /** read-only */
		
		
		public function Video()
		{
			
		}
		
		
		internal function initialize
			( parent   :DisplayObjectContainer
			, width    :int
			, height   :int
			, scale    :int
			, frameRate:int ):void
		{
			buffer             = new BitmapData(width, height, true, 0x00000000);
			bitmap             = new Bitmap(buffer, PixelSnapping.ALWAYS);
			bitmap.scaleX      = bitmap.scaleY = scale;
			
			parent.addChild(bitmap);
			
			var stage:Stage    = parent.stage;
			stage.displayState = StageDisplayState.NORMAL;
			stage.align        = StageAlign.TOP_LEFT;
			stage.quality      = StageQuality.MEDIUM;
			stage.scaleMode    = StageScaleMode.NO_SCALE;
			stage.frameRate    = frameRate;
			
			this.parent        = parent;
			this.width         = width;
			this.height        = height;
			this.scale         = scale;
			this.frameRate     = frameRate;
		}
		
	}

}
