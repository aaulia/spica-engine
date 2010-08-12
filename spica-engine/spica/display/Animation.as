package spica.display
{
	import spica.core.Entity;
	import spica.core.RenderContext;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Animation extends Entity
	{
		public  var y        :int               = 0;
		public  var x        :int               = 0;
		
		public  var scroll   :Number            = 1.0;
		public  var offsetX  :int               = 0;
		public  var offsetY  :int               = 0;
		
		
		private var sprite   :Sprite            = null;
		private var sequences:Vector.<Sequence> = null;
		private var seqIndex :int               = -1;
		private var frmIndex :int               = 0;
		private var timer    :Number            = 0;
				
		public function Animation(linkage:Class, width:int, height:int)
		{
			sprite    = new Sprite(linkage, width, height);
			sequences = new Vector.<Sequence>();
			isActive  = false;
		}
		
		public function loadBitmap(linkage:Class, width:int, height:int):Animation
		{
			sprite.loadBitmap(linkage, width, height);
			clearSequences();
			
			return this;
		}
		
		public function get width() :int { return sprite.width;  }
		public function get height():int { return sprite.height; }
		
		public function addSequence(name:String, indexes:Array, fps:int):Animation
		{
			sequences.push(new Sequence(name, indexes, fps));
			return this;
		}
		
		public function play(name:String = ""):Animation
		{
			if (name != "")
				seqIndex = getSequenceIndex(name);
				
			isActive = (seqIndex > -1);
			return this;
		}
		
		public function stop():Animation
		{
			frmIndex = 0;
			timer    = 0;
			isActive = false;
			
			return this;
		}
		
		public function pause():Animation
		{
 			isActive = false;
			return this;
		}
		
		public function clearSequences():Animation
		{
			sequences = new Vector.<Sequence>();
			seqIndex  = -1;
			stop();
			return this;
		}
		
		public function get sequenceName():String
		{
			return seqIndex >= 0
				? sequences[ seqIndex ].name
				: "";
		}
		
		private function getSequenceIndex(name:String):int
		{
			var length:int = sequences.length;
			for (var i:int = 0; i < length; ++i)
				if (sequences[ i ].name == name)
					return i;
			
			return -1;
		}
		
		override public function render(render:RenderContext):void
		{
			sprite.x       = x;
			sprite.y       = y;
			sprite.offsetX = offsetY;
			sprite.offsetY = offsetX;
			sprite.scroll  = scroll;
			sprite.frame   = sequences[ seqIndex ].indexes[ frmIndex ];
			
			sprite.render(render);
		}

		override public function update(elapsed:Number):void
		{
			if (seqIndex == -1)
				return;
				
			timer += elapsed;
			while (timer >= sequences[ seqIndex ].delay)
			{
				timer -= sequences[ seqIndex ].delay;
				frmIndex++;
			}
			
			frmIndex %= sequences[ seqIndex ].length;
		}
		
		
		
		override public function shutdown():void
		{
			sprite.shutdown();
			
			sprite    = null;
			sequences = null;
			seqIndex  = -1;
			frmIndex  = -1;
		}
		
	}

}



class Sequence
{
	public var name   :String = "";
	public var indexes:Array  = [];
	public var delay  :Number = 0;
	public var length :int    = 0;
	
	public function Sequence(name:String, indexes:Array, fps:int)
	{
		this.name    = name;
		this.indexes = indexes.concat();
		this.delay   = 1 / fps;
		this.length  = indexes.length;
	}
	
}
