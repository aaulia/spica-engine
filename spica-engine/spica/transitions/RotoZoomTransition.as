package spica.transitions
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import spica.core.Scene;
	import spica.core.SceneTransition;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class RotoZoomTransition extends SceneTransition
	{
		private const SCENE_ERROR:int = -1;
		private const SCENE_LEAVE:int =  0;
		private const SCENE_ENTER:int =  1;
		private const SCENE_ENDED:int =  2;
		
		private const DOUBLE_PI:Number = Math.PI * 2;
		
		private var matrix:Matrix = null;
		private var scale :Number = 0.0;
		private var state :int    = SCENE_ERROR;
		
		public function RotoZoomTransition(dst:Scene)
		{
			super(dst);
		}
		
		override public function initiate():void
		{
			matrix = new Matrix();
			scale  = 1.0;
			state  = SCENE_LEAVE;
		}
		
		private function updateTransform(scale:Number, angle:Number):void
		{
			matrix.identity();
			matrix.translate( -src.width >> 1, -src.height >> 1);
			matrix.scale    (scale, scale);
			matrix.rotate   (angle);
			matrix.translate(  src.width >> 1,  src.height >> 1);
			
			video.bitmap.transform.matrix = matrix;
		}
		
		override public function transition(elapsed:Number):Boolean
		{
			switch(state)
			{
				case SCENE_LEAVE:
				{
					scale -= elapsed;
					if (scale < 0)
					{
						scale = 0;
						state = SCENE_ENTER;
						video.buffer.copyPixels(dst, dst.rect, new Point());
					}
					
					updateTransform(scale, scale * DOUBLE_PI);
					break;
				}
				
				case SCENE_ENTER:
				{
					scale += elapsed;
					if (scale > 1)
					{
						scale = 1;
						state = SCENE_ENDED;
					}
					
					updateTransform(scale, scale * DOUBLE_PI);
					break;
				}
				
			}
			
			return state == SCENE_ENDED;
		}
		
	}

}
