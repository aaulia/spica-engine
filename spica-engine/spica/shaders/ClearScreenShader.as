package spica.shaders
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import spica.core.Shader;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class ClearScreenShader extends Shader
	{
		public  var color :uint       = 0x00000000;
		private var buffer:BitmapData = null;
		private var point :Point      = null;
		
		public function ClearScreenShader(width:int, height:int, color:uint = 0x00000000)
		{
			this.color  = color;
			this.buffer = new BitmapData(width, height, true, color);
			this.point  = new Point();
		}
		
		override public function preRender(source:BitmapData):void
		{
			source.copyPixels(buffer, buffer.rect, point);
		}
		
		override public function shutdown():void
		{
			if (buffer != null)
				buffer.dispose();
				
			buffer = null;
			point  = null;
			color  = 0x00000000;
		}
	}

}
