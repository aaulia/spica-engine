package spica.core
{
	import flash.display.DisplayObjectContainer;
	import spica.core.Game;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class Director
	{
		public function Director()             { }
		public function goTo(scene:Class):void { next = scene; }
		
		
		private var parent:DisplayObjectContainer = null;
		private var game  :Game                   = null;
		private var active:Scene                  = null;
		private var next  :Class                  = null;
		
		
		internal function initialize(parent:DisplayObjectContainer, game:Game):void
		{
			this.parent = parent;
			this.game   = game;
			this.active = new NullScene(game);
		}
		
		
		internal function step   ()                     :void { active.step();          }
		internal function update (elapsed:int)          :void { active.update(elapsed); }
		internal function render (context:RenderContext):void { active.render(context); }
		internal function onFocus(focus:Boolean)        :void { active.onFocus(focus);  }
		
		
		internal function verify():Boolean
		{
			if (next != null)
			{
				if (active != null) active.dispose();
					
				active = new next(game);
				next   = null
				
				if (active != null) active.startup();
				
				return true;
			}
			
			return false;
		}
		
	}

}

import spica.core.Game;
import spica.core.Scene;
class NullScene extends Scene { public function NullScene(game:Game) { super(game); } }
