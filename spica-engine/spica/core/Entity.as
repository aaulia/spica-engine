package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Entity
	{
		public var alive  :Boolean = true;	/** flag for polling       */
		public var visible:Boolean = true;	/** flag for rendering     */
		public var active :Boolean = true;	/** flag for update & tick */
		
		
		public function step   ()                     :void { /** override */ }
		public function update (elapsed:int)          :void { /** override */ }
		public function render (context:RenderContext):void { /** override */ }
		public function dispose()                     :void { /** override */ }
		
	}

}
