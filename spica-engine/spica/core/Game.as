package spica.core
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Game
	{
		public  var video  :VideoDriver   = null;
		public  var audio  :AudioDriver   = null;
		public  var input  :InputDriver   = null;
		
		
		public  var camera :Camera        = null;
		public  var scene  :SceneManager  = null;
		
		
		private var stage  :Stage         = null;
		private var context:RenderContext = null;
		private var focus  :Boolean       = true;
		
		
		public function Game(stage:Stage)
		{
			this.stage = stage;
		}
		
		
		private var maxDelta :int = 68;
		private var gameTick :int = 34;
		private var frameSkip:int = 2;

		
		public function initiate(width:int, height:int, scale:Number = 1.0, displayRate:int = 60, logicRate:int = 30, skip:int = 2):Game
		{
			video     = new VideoDriver(stage, width, height, displayRate, scale);
			audio     = new AudioDriver();
			input     = new InputDriver(stage);
			
			video.initiate();
			audio.initiate();
			input.initiate();
			
			camera    = new Camera(width, height);
			scene     = new SceneManager(this);
			context   = new RenderContext(video.buffer, camera);
			
			gameTick  = int(Math.ceil(1000 / logicRate));
			frameSkip = skip;
			maxDelta  = gameTick * frameSkip;
			
			return this;
		}
		
		
		private var old:int = 0;
		private var now:int = 0;
		private var acc:int = 0;	// accumulator
		private var frm:int = 0;	// frame time (under ideal situation, this is == dt)
		private var dt :int = 0;	// delta time

		
		public function run(entryPoint:Scene):Game
		{
			scene.goTo(entryPoint);
			
			stage.addEventListener(Event.ACTIVATE   , onRecvFocus );
			stage.addEventListener(Event.DEACTIVATE , onLostFocus );
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
			old = getTimer();
			return this;
		}
		
		
		private function onRecvFocus(e:Event):void
		{
			if (!focus)
				focus = true;
				
		}
		
		
		private function onLostFocus(e:Event):void
		{
			focus = false;
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			if (!focus)
				return;
			
			now = getTimer();
			dt  = now - old;
			old = now;
			
			if (dt > maxDelta)
				dt = maxDelta;
				
			acc += dt;
			frm  = 0;
			while (acc >= gameTick)
			{
				scene.doStep();
				
				acc -= gameTick;
				frm += gameTick;
			}
			
			input.update();
			scene.update(frm * 0.001);
			
			context.interpolation = acc / gameTick;
			scene.render(context);
			
			scene.validate();
		}
		
		
		public function shutdown():void
		{
			scene.shutdown();
			video.shutdown();
			audio.shutdown();
			input.shutdown();
		}
		
	}

}
