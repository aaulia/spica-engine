package spica.core
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	import spica.utility.ContextMenuManager;
	/**
	 * Game Framework class
	 * @author Achmad Aulia Noorhakim
	 */
	public class Game
	{
		internal const FP_MAJOR:int = 10;
		internal const FP_MINOR:int = 1;
		
		
		internal var audio      :Audio                  = null; /** read-only */
		internal var camera     :Camera                 = null; /** read-only */
		internal var contextMenu:ContextMenuManager     = null; /** read-only */
		internal var director   :Director               = null; /** read-only */
		internal var input      :Input                  = null; /** read-only */
		internal var video      :Video                  = null; /** read-only */
		
		
		private  var parent     :DisplayObjectContainer = null;
		private  var logicRate  :int                    = 0;
		private  var context    :RenderContext          = null;
		
		
		private  var frameSkip  :int                    = 0;
		private  var gameTick   :int                    = 0;
		private  var maxDelta   :int                    = 0;
		private  var invTick    :Number                 = 0.0;
		
		
		public function initialize(
			parent   :DisplayObjectContainer,
			width    :int,
			height   :int,
			scale    :Number = 1.0,
			frameRate:int    = 60,
			logicRate:int    = 60,
			frameSkip:int    = 2 ):Boolean
		{
			var version :Array   = Capabilities.version.split(" ")[ 1 ].split(",");
			var major   :int     = int(version[ 0 ]);
			var minor   :int     = int(version[ 1 ]);
			var valid   :Boolean = true;
			
			if (major  < FP_MAJOR)                     valid = false;
			if (major == FP_MAJOR && minor < FP_MINOR) valid = false;
			
			if (valid)
			{
				audio          = new Audio   ();
				camera         = new Camera  (width, height);
				contextMenu    = new ContextMenuManager(parent);
				director       = new Director();
				video          = new Video   ();
				input          = new Input   ();
			
				audio   .initialize(parent);
				director.initialize(parent, this);
				input   .initialize(parent);
				video   .initialize(parent, width, height, scale, frameRate);
				
				this.parent    = parent;
				this.logicRate = logicRate;
				this.context   = new RenderContext(video.buffer, camera);
				
				this.gameTick  = int(Math.ceil(1000 / logicRate));
				this.invTick   = 1 / gameTick;
				this.frameSkip = frameSkip;
				this.maxDelta  = frameSkip * gameTick;
				
				FontCache.regFont("default", DINA_PNG, DINA_FNT);
			}
			else
			{
				var msg:TextField     = new TextField();
				msg.selectable        = false;
				msg.autoSize          = TextFieldAutoSize.LEFT;
				msg.defaultTextFormat = new TextFormat("Arial", 12, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.CENTER);
				msg.htmlText          =
					"This game require flash player version " + FP_MAJOR + "." + FP_MINOR + " and above\n" +
					"You have version " + major + "." + minor + ".\n" +
					"Please update your flash player";
				
				msg.x                 = (width  - msg.width)  / 2;
				msg.y                 = (height - msg.height) / 2;
				
				parent.addChild(msg);
			}
			
			return valid;
		}
		
		
		
		private var old:int = 0;
		private var now:int = 0;
		
		
		public function run(entryScene:Class):void
		{
			parent.stage.addEventListener(Event.ACTIVATE  , onFocusEvent);
			parent.stage.addEventListener(Event.DEACTIVATE, onFocusEvent);
			parent.addEventListener(Event.ENTER_FRAME     , onEnterFrame);
			
			old =
			now = getTimer();
			
			director.goTo(entryScene);
		}
		
		
		private function onFocusEvent(e:Event):void
		{
			director.onFocus(e.type == Event.ACTIVATE);
		}

		
		private var acc:int = 0;
		private var frm:int = 0;
		private var gap:int = 0;
		
		
		private function onEnterFrame(e:Event):void
		{
			now = getTimer();
			gap = now - old;
			old = now;
			frm = 0;
			
			if (gap > maxDelta)
				gap = maxDelta;
				
			acc += gap;
			while (acc >= gameTick)
			{
				input.refresh();
				director.step();
				
				acc -= gameTick;
				frm += gameTick;
			}
			
			context.alpha = (acc * invTick);
			director.update(frm);
			
			context.buffer.lock();
			director.render(context);
			context.buffer.unlock();
			
			if (director.verify())
			{
				input .clear();
				camera.reset();
			}
			
		}

		
		/**
		 * default font
		 */
		[Embed(source = './data/Dina.fnt', mimeType = 'application/octet-stream')]
		private const DINA_FNT:Class;
		
		[Embed(source = './data/Dina.png')]
		private const DINA_PNG:Class;
		
	}

}
