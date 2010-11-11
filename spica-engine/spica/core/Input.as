package spica.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class Input
	{
		public  var mouseB:int                    = 0;						/** read-only */
		public  var mouseX:int                    = 0;						/** read-only */
		public  var mouseY:int                    = 0;						/** read-only */
		public  var keys  :Vector.<int>           = new Vector.<int>();		/** read-only */
		
		private var parent:DisplayObjectContainer = null;
		private var stage :Stage                  = null;
		private var button:Boolean                = false;					/** mouse button state  */
		private var down  :Vector.<Boolean>       = new Vector.<Boolean>();	/** keyboard keys state */
		
		
		public function Input()
		{
			for (var i:int = 0; i < 256; ++i)
			{
				keys[ i ] = 0;
				down[ i ] = false;
			}
			
		}
		
		
		public function clear():void
		{
			for (var i:int = 0; i < 256; ++i)
			{
				keys[ i ] = 0;
				down[ i ] = false;
			}
		}
	
		
		internal function initialize(parent:DisplayObjectContainer):void
		{
			this.parent = parent;
			this.stage  = parent.stage;
			
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN , onMouseDn);
			this.stage.addEventListener(MouseEvent.MOUSE_UP   , onMouseUp);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,   onKeyDn);
			this.stage.addEventListener(KeyboardEvent.KEY_UP  ,   onKeyUp);
		}
		
		
		private function onMouseDn(e:MouseEvent)   :void { button            = true;  }
		private function onMouseUp(e:MouseEvent)   :void { button            = false; }
		private function onKeyDn  (e:KeyboardEvent):void { down[ e.keyCode ] = true;  }
		private function onKeyUp  (e:KeyboardEvent):void { down[ e.keyCode ] = false; }
		
		
		internal function refresh():void
		{
			var k:int      = 0;
			var d:Boolean  = false;
			
			for (var i:int = 0; i < 256; ++i)
			{
				k = keys [ i ];
				d = down[ i ];
				
				if (   !d) k = 0; else
				if (k < 2) k++;
				
				keys[ i ] = k;
			}
			
			if (   !button) mouseB = 0; else
			if (mouseB < 2) mouseB++;
			
			mouseX = stage.mouseX;
			mouseY = stage.mouseY;
		}
		
	}

}
