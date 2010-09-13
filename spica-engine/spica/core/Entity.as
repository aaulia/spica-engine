package spica.core
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Entity
	{
		public var isAlive  :Boolean = true;
		public var isActive :Boolean = true;
		public var isVisible:Boolean = true;
		
		
		public function doStep  ()                     :void { }
		public function update  (elapsed:Number)       :void { }
		public function render  (context:RenderContext):void { }
		public function shutdown()                     :void { }
		
	}

}
