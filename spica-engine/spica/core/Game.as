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
		
		private var elapse:int           = 0;
		private var slice :int           = 0;
		
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
			timer  = new TimerManager(fps);
			camera = new Camera(width, height);
			render = new RenderContext(video.buffer, camera);
			
			elapse = 0;
			slice  = int(1000.0 / fps + 0.5);
			
			return this;
		}
		
		public function run(entryPoint:Scene, fixedRate:Boolean = false):Game
		{
			scene.goTo(entryPoint);
			if (fixedRate)
				stage.addEventListener(Event.ENTER_FRAME, doFixedRateTick);
			else 
				stage.addEventListener(Event.ENTER_FRAME, doTimeBasedTick);
			
			return this;
		}
		
		private function doFixedRateTick(e:Event):void 
		{
			input.update();
			timer.update();
			
			elapse += timer.elapsedInt;
			if (elapse > slice)
			{
				scene.update(int(elapse / slice));
				elapse %= slice;
			}
			
			render.buffer.lock();
				scene.render(render);
			render.buffer.unlock();
			
			scene.validate();
		}
		
		private function doTimeBasedTick(e:Event):void
		{
			input.update();
			timer.update();
			
			scene.update(timer.elapsed);
			
			render.buffer.lock();
				scene.render(render);
			render.buffer.unlock();
			
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
