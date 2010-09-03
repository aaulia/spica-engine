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
		private static const MAX_DELTA:int = 33;
		
		
		public  var video :VideoDriver   = null;
		public  var audio :AudioDriver   = null;
		public  var input :InputDriver   = null;
		
		
		public  var camera:Camera        = null;
		public  var scene :SceneManager  = null;
		
		
		private var stage :Stage         = null;
		private var render:RenderContext = null;
		
		
		public function Game(stage:Stage)
		{
			this.stage = stage;
		}
		
		
		public function initiate(width:int, height:int, fps:int, scale:Number):Game
		{
			video  = new VideoDriver(stage, width, height, fps, scale);
			audio  = new AudioDriver();
			input  = new InputDriver(stage);
			
			video.initiate();
			audio.initiate();
			input.initiate();
			
			scene  = new SceneManager(this);
			camera = new Camera(width, height);
			render = new RenderContext(video.buffer, camera);
			
			return this;
		}
		
		
		private var old:int = 0;
		private var now:int = 0;
		private var dt :int = 0;

		
		public function run(entryPoint:Scene):Game
		{
			scene.goTo(entryPoint);
			stage.addEventListener(Event.ENTER_FRAME, update);
		
			old = getTimer();
			
			return this;
		}
		
		
		private function update(e:Event):void
		{
			input.update();
			
			now = getTimer();
			dt  = now - old;
			old = now;
			
			if (dt > MAX_DELTA)
				dt = MAX_DELTA;
				
			scene.update(dt * 0.001);
			scene.render(render);
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
