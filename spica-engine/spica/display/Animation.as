package spica.display
{
	import spica.core.RenderContext;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Animation extends Visual
	{
		private var spr:Sprite       = null;
		public function get sprite():Sprite { return spr; }
		public function set sprite(v:Sprite):void
		{
			if (v != spr)
			{
				width   = v.width;
				height  = v.height;
				spr = v;
			}
			
		}
		
		public  var name   :String   = "";				/** read-only */
		public  var current:Sequence = null;			/** read-only */
		
		
		private var series :Object   = new Object();
		private var timer  :int      = 0;
		private var delta  :int      = 0;
		private var index  :int      = 0;
		private var loop   :int      = 0;
		
		
		private var playing:Boolean  = false;
		public function get isPlaying():Boolean
		{
			return playing;
		}
		
		
		public function Animation(sprite:Sprite = null)
		{
			this.sprite = sprite;
		}
		
		
		public function addSeq(name:String, frames:Vector.<int>, fps:int):void
		{
			series[ name ] =
			current        = new Sequence(frames, fps);
			this.name      = name;
		}
		
		
		public function clear():void
		{
			stop();
			for each (var n:String in series)
				series[ n ] = null;
				
			name    = "";
			current = null;
		}
		
		
		public function play(name:String = "", loop:int = 0):void
		{
			if (name == "")
				return;
				
			if (!playing || this.name != name)
			{
				this.name = name;
				current   = series[ this.name ];
				
				if (current == null)
					throw "[Animation:Error] There is no sequence named: " + name + "!";
				
				index     = 0;
				delta     = int(1000 / current.fps);
				timer     = 0;
			}
			
			if (delta <= 0)
				throw "Something is VERY wrong with the animation " + name + ", delta time shouldn't be 0 or less >.<!\n"
			
			this.loop = loop;
			playing   = true;
		}
		
		
		public function stop():void
		{
			playing = false;
		}
		
		
		override public function update(elapsed:int):void
		{
			if (playing == false)
				return;
				
			timer += elapsed;
			while (timer >= delta)
			{
				index  = (index + 1) % current.length;
				if (index == 0)
					if (loop > 0)
						if (--loop == 0)
						{
							index = current.length - 1;
							stop();
						}
				
				timer -= delta;
			}
			
		}
		
		
		override public function render(context:RenderContext):void
		{
			if (spr == null || current == null || context.buffer == null)
				return;
			
			spr.x       = x;
			spr.y       = y;
			spr.offsetX = offsetX;
			spr.offsetY = offsetY;
			spr.scrollX = scrollX;
			spr.scrollY = scrollY;
			spr.frame   = current.frames[ index ];
			
			spr.render(context);
		}
		
		
		override public function dispose():void
		{
			clear();
			if (spr)
				spr.dispose();
				
		}
		
	}

}


class Sequence
{
	public var frames:Vector.<int> = null;	/** read-only */
	public var fps   :int          = 0;		/** read-only */
	public var length:int          = 0;		/** read-only */
	
	
	public function Sequence(frames:Vector.<int>, fps:int)
	{
		this.frames = frames.concat();
		this.fps    = fps;
		this.length = frames.length;
	}
	
	
	public function toString():String
	{
		return "[Sequence frames=" + frames + " fps=" + fps + " length=" + length + "]";
	}
	
}
