package spica.display 
{
	import spica.core.Entity;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Visual extends Entity
	{
		public  var x      :int    = 0;
		public  var y      :int    = 0;
		
		
		public  var scroll :Number = 1.0;
		public  var offsetX:int    = 0;
		public  var offsetY:int    = 0;
		
		
		public function get width ():int { return 0; }
		public function get height():int { return 0; }
		
		
		public function Visual() 
		{
			
		}
		
	}

}