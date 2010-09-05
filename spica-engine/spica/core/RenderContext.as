package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class RenderContext
	{
		public var buffer       :BitmapData = null;
		public var camera       :Camera     = null;
		public var interpolation:Number     = 1.0;
		
		
		public function RenderContext(buffer:BitmapData, camera:Camera, interpolation:Number = 1.0)
		{
			this.buffer        = buffer;
			this.camera        = camera;
			this.interpolation = interpolation;
		}
		
	}

}
