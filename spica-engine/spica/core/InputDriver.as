package spica.core
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import spica.enum.Button;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class InputDriver
	{
		private var stage    :Stage              = null;
		
		private var keyDown  :Vector.<Boolean>   = null;
		private var keyBtn   :Vector.<int>       = null;
		
		private var mouseDown:Boolean            = false;
		private var _mouseBtn:int                = 0;
		private var _mouseX  :int                = 0;
		private var _mouseY  :int                = 0;
		
		public function set showDefaultPointer(v:Boolean):void
		{
			v == true
			? Mouse.show()
			: Mouse.hide();
		}
		
		public function InputDriver(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function get mouseX()  :int { return _mouseX;   }
		public function get mouseY()  :int { return _mouseY;   }
		public function get mouseBtn():int { return _mouseBtn; }
		
		public function getKeyState(key:int):int
		{
			return key < 256
				? keyBtn[ key ]
				: -1;
		}
		
		internal function initiate():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN  , onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP    , onKeyUp);
			stage.addEventListener(MouseEvent   .MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent   .MOUSE_UP  , onMouseUp);
			
			keyDown = new Vector.<Boolean>(256, true);
			keyBtn  = new Vector.<int>(256, true);
			for (var i:int = 0; i < 256; ++i)
			{
				keyDown[ i ] = false;
				keyBtn [ i ] = Button.RELEASE;
			}
			
			mouseDown = false;
			_mouseBtn = Button.RELEASE;
			_mouseX   = -1;
			_mouseY   = -1;
		}
		
		private function onKeyDown  (e:KeyboardEvent):void { keyDown[ e.keyCode ] = true; }
		private function onKeyUp    (e:KeyboardEvent):void { keyDown[ e.keyCode ] = false; }
		private function onMouseDown(e:MouseEvent)   :void { mouseDown = true; }
		private function onMouseUp  (e:MouseEvent)   :void { mouseDown = false; }
		
		internal function update():void
		{
			for (var i:int = 0; i < 256; ++i)
			{
				if (keyDown[ i ])
				{
					if (Button.HOLD < ++keyBtn[ i ])
						keyBtn[ i ] = Button.HOLD;
						
				}
				else
				{
					keyBtn[ i ] = Button.RELEASE;
				}
			}
			
			_mouseX = stage.mouseX;
			_mouseY = stage.mouseY;
			
			if (mouseDown)
			{
				if (Button.HOLD < ++_mouseBtn)
					_mouseBtn = Button.HOLD;
					
			}
			else
			{
				_mouseBtn = Button.RELEASE;
			}
			
		}
		
		internal function shutdown():void
		{
			if (null != stage)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN  , onKeyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP    , onKeyUp);
				stage.removeEventListener(MouseEvent   .MOUSE_DOWN, onMouseDown);
				stage.removeEventListener(MouseEvent   .MOUSE_UP  , onMouseUp);
			}
			
			stage   = null;
			keyDown = null;
			keyBtn  = null;
		}
		
	}

}
