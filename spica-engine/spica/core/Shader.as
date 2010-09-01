package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Shader
	{
		public var isActive:Boolean = true;
		
		
		public function preRender (source:BitmapData):void { }
		public function postRender(source:BitmapData):void { }
		public function shutdown  ()                 :void { }
		
	}

}
