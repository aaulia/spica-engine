package spica.core
{
	import flash.display.BitmapData;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class SceneTransition extends Scene
	{
		private var replace:Function  = null;
		
		protected var src :BitmapData = null;
		protected var dst :BitmapData = null;
		protected var next:Scene      = null;
		
		public function SceneTransition(dst:Scene)
		{
			this.next = dst;
		}
		
		public function transition(elapsed:Number):Boolean
		{
			return true;
		}
		
		internal function setup(game:Game, replace:Function):void
		{
			this.replace = replace;
			
			this.injectDependency(game);
			src = video.buffer.clone();
			dst = video.buffer.clone();
			
			next.injectDependency(game);
			next.initiate();
			next.render(new RenderContext(dst, camera));
		}
		
		override public function update(elapsed:Number):void
		{
			if (transition(elapsed))
			{
				src.dispose();
				dst.dispose();
				
				replace(next);
			}
			
		}
		
	}

}
