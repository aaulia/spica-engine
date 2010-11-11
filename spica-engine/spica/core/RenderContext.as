package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class RenderContext
	{
		public var buffer:BitmapData = null; /** read-only */
		public var camera:Camera     = null; /** read-only */
		public var alpha :Number     = 1.0;  /** read-only */
		
		
		public function RenderContext
			( buffer:BitmapData
			, camera:Camera = null
			, alpha  :Number = 1.0 )
		{
			this.buffer = buffer;
			this.camera = camera;
			this.alpha   = alpha;
		}
		
	}

}
