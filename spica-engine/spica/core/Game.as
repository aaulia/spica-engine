package spica.core
{
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Game
	{
		public  var video :VideoDriver   = null;
		public  var audio :AudioDriver   = null;
		public  var input :InputDriver   = null;
		
		public  var camera:Camera        = null;
		public  var scene :SceneManager  = null;
		
		private var stage :Stage         = null;
		private var timer :TimerManager  = null;
		private var render:RenderContext = null;
		
		public function Game(stage:Stage)
		{
			this.stage = stage;
		}
		
		public function initiate(width:int, height:int, fps:int):Game
		{
			video  = new VideoDriver(stage, width, height, fps);
			audio  = new AudioDriver();
			input  = new InputDriver(stage);
			
			video.initiate();
			audio.initiate();
			input.initiate();
			
			scene  = new SceneManager(this);
			timer  = new TimerManager(fps);
			camera = new Camera(width, height);
			render = new RenderContext(video.buffer, camera);
			
			return this;
		}
		
		public function run(entryPoint:Scene):Game
		{
			scene.goTo(entryPoint);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			return this;
		}
		
		public function shutdown():void
		{
			scene.shutdown();
			video.shutdown();
			audio.shutdown();
			input.shutdown();
		}
		
		private function onEnterFrame(e:Event):void
		{
			input.update();
			timer.update();
			
			scene.update(timer.elapsed);
			scene.render(render);
			scene.validate();
		}
		
	}

}
