package spica.transitions
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spica.core.Scene;
	import spica.core.SceneTransition;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class VerticalSplitColumnTransition extends SceneTransition
	{
		private const SCENE_ERROR:int = -1;
		private const SCENE_LEAVE:int =  0;
		private const SCENE_ENTER:int =  1;
		private const SCENE_ENDED:int =  2;
		
		private var timer      :Number                = 0.0;
		private var state      :int                   = SCENE_ERROR;
		private var filter     :DisplacementMapFilter = null;
		private var map        :BitmapData            = null;
		private var scale      :Number                = 0.0;
		private var value      :Number                = 0;
		private var split      :int                   = 0;
		private var orientation:int                   = 0;
		
		public function VerticalSplitColumnTransition(dst:Scene, split:int = 3, orientation:int = 0)
		{
			super(dst);
			this.split       = split;
			this.orientation = orientation;
		}
		
		override public function initiate():void
		{
			var blockRect:Rectangle =
				orientation == 0
				? new Rectangle(0, 0, video.width / split, video.height)
				: new Rectangle(0, 0, video.width, video.height / split);
			
			map = video.buffer.clone();
			map.fillRect(map.rect , 0xFFFFFFFF);
			
			var splitFactor:int = Math.ceil(split / 2) as int;
			for (var i:int = 0; i < splitFactor; ++i)
			{
				orientation == 0
				? blockRect.x = blockRect.width  * (2 * i)
				: blockRect.y = blockRect.height * (2 * i);
				
				map.fillRect(blockRect, 0xFF000000);
			}
			
			filter = new DisplacementMapFilter(
				map,
				new Point(),
				(orientation == 0 ? 0 : BitmapDataChannel.RED),
				(orientation == 0 ? BitmapDataChannel.RED : 0),
				0,
				0,
				DisplacementMapFilterMode.COLOR);
			
			scale = (orientation == 0 ? video.height : video.width) * 2.5;
			value = 0;
			state = SCENE_LEAVE;
		}
		
		override public function shutdown():void
		{
			map.dispose();
			
			filter = null;
			map    = null;
		}
		
		private function updateFilter(v:Number):void
		{
			orientation     == 0
			? filter.scaleY = v
			: filter.scaleX = v;
			
			video.bitmap.filters = [ filter ];
		}
		
		override public function transition(elapsed:Number):Boolean
		{
			switch(state)
			{
				case SCENE_LEAVE:
				{
					value += scale * elapsed;
					if (value > scale)
					{
						value = scale;
						state = SCENE_ENTER;
						video.buffer.copyPixels(dst, dst.rect, new Point());
					}

					updateFilter(value);
					break;
				}
				
				case SCENE_ENTER:
				{
					value -= scale * elapsed;
					if (value < 0)
					{
						state = SCENE_ENDED;
						value = 0;
						video.bitmap.filters = null;
					}
					else
						updateFilter(value);
					
					break;
				}
				
			}
			
			return state == SCENE_ENDED;
		}
		
	}

}
