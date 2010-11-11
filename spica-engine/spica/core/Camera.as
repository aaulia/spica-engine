package spica.core
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Camera
	{
		public  var x      :Number = 0.0;
		public  var y      :Number = 0.0;
		
		
		private var centerX:int    = 0;
		private var centerY:int    = 0;
		
		
		public function Camera(width:int, height:int)
		{
			centerX = width  >> 1;
			centerY = height >> 1;
			reset();
		}
		
		
		public function reset():void
		{
			x = centerX;
			y = centerY;
		}
		
		
		public function get offsetX():int { return centerX - x; }
		public function get offsetY():int { return centerY - y; }
		
		
		public function centerTo(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
	}

}
