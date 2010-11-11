package spica.core
{
	import flash.display.BitmapData;
	import spica.core.Game;
	import spica.utility.ContextMenuManager;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Scene
	{
		protected var audio      :Audio              = null; /** read-only */
		protected var camera     :Camera             = null; /** read-only */
		protected var contextMenu:ContextMenuManager = null; /** read-only */
		protected var director   :Director           = null; /** read-only */
		protected var input      :Input              = null; /** read-only */
		protected var video      :Video              = null; /** read-only */
		
		
		public function Scene(game:Game)
		{
			setup(game);
		}
		
		
		private function setup(game:Game):void
		{
			audio       = game.audio;
			camera      = game.camera;
			contextMenu = game.contextMenu;
			director    = game.director;
			input       = game.input;
			video       = game.video;
		}
		
		
		public function startup()                     :void { /** override */ }
		public function dispose()                     :void { /** override */ }
		
		public function step   ()                     :void { /** override */ }
		public function update (elapsed:int)          :void { /** override */ }
		public function render (context:RenderContext):void { /** override */ }
		
		public function onFocus(focus:Boolean)        :void { /** override */ }
		
	}
		
}
