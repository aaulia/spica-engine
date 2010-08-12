package spica.shaders
{
	import flash.display.BitmapData;
	import spica.core.Shader;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class ClearScreenShader extends Shader
	{
		public var color:uint = 0x0;
		
		public function ClearScreenShader(color:uint = 0x0)
		{
			this.color = color;
		}
		
		override public function preRender(source:BitmapData):void
		{
			source.fillRect(source.rect, color);
		}
		
	}

}
