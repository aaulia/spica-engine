package spica.core
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Scene
	{
		public function initiate():void { }
		public function shutdown():void { }
		
		
		public function update(elapsed:Number)      :void { }
		public function render(render:RenderContext):void { }

		
		protected var video :VideoDriver   = null;
		protected var audio :AudioDriver   = null;
		protected var input :InputDriver   = null;
		protected var scene :SceneManager  = null;
		protected var camera:Camera        = null;
		
		
		internal function injectDependency(game:Game):void
		{
			video  = game.video;
			audio  = game.audio;
			input  = game.input;
			scene  = game.scene;
			camera = game.camera;
		}
		
	}

}
