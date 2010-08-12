package spica.core
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Camera
	{
		public  var x       :int = 0;
		public  var y       :int = 0;
		
		private var center_x:int = 0;
		private var center_y:int = 0;
		
		public function Camera(width:int, height:int)
		{
			center_x = width  >> 1;
			center_y = height >> 1;
			reset();
		}
		
		public function reset():void
		{
			x = center_x;
			y = center_y;
		}
		
		public function get offsetX():int { return x - center_x; }
		public function get offsetY():int { return y - center_y; }
		
		public function centerTo(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
	}

}
