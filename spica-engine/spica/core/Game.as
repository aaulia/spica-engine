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
		
		
		public function Game(stage:Stage)
		{
			this.stage = stage;
		}
		
		
		public function initiate(width:int, height:int, fps:int, scale:Number):Game
		{
			video   = new VideoDriver(stage, width, height, fps, scale);
			audio   = new AudioDriver();
			input   = new InputDriver(stage);
			
			video.initiate();
			audio.initiate();
			input.initiate();
			
			scene   = new SceneManager(this);
			camera  = new Camera(width, height);
			context = new RenderContext(video.buffer, camera);
			
			return this;
		}
		
		
		private const MAX_DELTA:int = 33;	// maximum dt is 33 ~ 30 frame per second
		private const GAME_TICK:int = 16;	// defaulting to 60-ish frame per second :-/
		
		
		private var old:int = 0;
		private var now:int = 0;
		private var acc:int = 0;	// accumulator
		private var frm:int = 0;	// frame time (under ideal situation, this is == dt)
		private var dt :int = 0;	// delta time

		
		public function run(entryPoint:Scene):Game
		{
			scene.goTo(entryPoint);
			stage.addEventListener(Event.ENTER_FRAME, update);
		
			old = getTimer();
			
			return this;
		}
		
		
		private function update(e:Event):void
		{
			now = getTimer();
			dt  = now - old;
			old = now;
			
			if (dt > MAX_DELTA)
				dt = MAX_DELTA;
				
			acc += dt;
			frm  = 0;
			while (acc >= GAME_TICK)
			{
				scene.onTick();
				
				acc -= GAME_TICK;
				frm += GAME_TICK;
			}
			
			input.update();
			scene.update(frm * 0.001);
			
			context.interpolation = acc / GAME_TICK;
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
