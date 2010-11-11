package spica.display
{
	import flash.geom.Point;
	import spica.core.Camera;
	import spica.core.Entity;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Visual extends Entity
	{
		public var width  :int    = 0; /** read-only */
		public var height :int    = 0; /** read-only */
		
		
		public var x      :Number = 0.0;
		public var y      :Number = 0.0;
		
		
		public var scrollX:Number = 1.0;
		public var scrollY:Number = 1.0;

		
		public var offsetX:int    = 0;
		public var offsetY:int    = 0;
		
		
		public function centerOffset():void
		{
			offsetX = width  >> 1;
			offsetY = height >> 1;
		}
		
		
		protected function calcRenderPos(cam:Camera, point:Point):void
		{
			if (cam != null)
			{
				point.x = int(x - offsetX + cam.offsetX * scrollX);
				point.y = int(y - offsetY + cam.offsetY * scrollY);
			}
			else
			{
				point.x = int(x - offsetX);
				point.y = int(y - offsetY);
			}
			
		}
		
	}

}
