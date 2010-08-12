package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class RenderContext
	{
		public var buffer:BitmapData = null;
		public var camera:Camera     = null;
		
		public function RenderContext(buffer:BitmapData, camera:Camera)
		{
			this.buffer = buffer;
			this.camera = camera;
		}
		
	}

}
