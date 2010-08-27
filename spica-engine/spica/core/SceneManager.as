package spica.core
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class SceneManager
	{
		private var game :Game  = null;
		private var scene:Scene = null;
		private var next :Scene = null;
		
		public function SceneManager(game:Game)
		{
			this.game = game;
		}
		
		public function goTo(scene:Scene):SceneManager
		{
			this.next = scene;
			if (this.scene == null)
				this.switchScene();
			
			return this;
		}
		
		private function onDirectReplace(scene:Scene):void
		{
			if (this.scene != null)
				this.scene.shutdown();
			
			this.scene = scene;
		}
		
		private function switchScene():void
		{
			if ((next is SceneTransition) == true)
				(next as SceneTransition)._setup_(game, onDirectReplace);
			else
				next._inject_(game);

			if (scene != null)
				scene.shutdown();
				
			scene = next;
			next  = null;
			
			scene.initiate();
		}
		
		internal function update(elapsed:Number):void
		{
			scene.update(elapsed);
		}
		
		internal function render(render:RenderContext):void
		{
			scene.render(render);
		}
		
		internal function validate():void
		{
			if (next != null)
				switchScene();
			
		}
		
		internal function shutdown():void
		{
			if (scene != null)
				scene.shutdown();
				
			game  = null;
			scene = null;
			next  = null;
		}
		
	}

}

