package spica.transitions
{
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import spica.core.RenderContext;
	import spica.core.Scene;
	import spica.core.SceneTransition;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class CrossFadeTransition extends SceneTransition
	{
		private var ctSrc:ColorTransform = null;
		private var ctDst:ColorTransform = null;
		
		public function CrossFadeTransition(dst:Scene)
		{
			super(dst);
		}
		
		override public function initiate():void
		{
			ctSrc = new ColorTransform(1, 1, 1, 1);
			ctDst = new ColorTransform(1, 1, 1, 0);
		}
	
		override public function transition(elapsed:Number):Boolean
		{
			ctSrc.alphaMultiplier -= elapsed;
			ctDst.alphaMultiplier += elapsed;
			
			return ctSrc.alphaMultiplier <= 0.0
				&& ctDst.alphaMultiplier >= 1.0;
		}
		
		override public function render(render:RenderContext):void
		{
			render.buffer.draw(dst, null, ctDst);
			render.buffer.draw(src, null, ctSrc);
		}
		
	}

}
