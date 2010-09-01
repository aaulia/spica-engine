package spica.transitions
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import spica.core.RenderContext;
	import spica.core.Scene;
	import spica.core.SceneTransition;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class PerlinSpreadTransition extends SceneTransition
	{
		private var perlin   :BitmapData = null;
		private var point    :Point      = null;

		
		private var threshold:uint       = 0;
		private var baseX    :Number     = 0;
		private var baseY    :Number     = 0;
		private var nOctave  :uint       = 0;
		
		
		public function PerlinSpreadTransition(
			dst    :Scene,
			baseX  :Number = 100,
			baseY  :Number = 100,
			nOctave:uint   = 1)
		{
			super(dst);
			
			this.baseX   = baseX;
			this.baseY   = baseY;
			this.nOctave = nOctave;
		}
		
		
		override public function initiate():void
		{
			threshold = 0;
			point     = new Point();
			perlin    = video.buffer.clone();
			perlin.fillRect(perlin.rect, 0x00000000);
			perlin.perlinNoise(baseX, baseY, nOctave, getTimer(), false, true, 0, true);
		}
		
		
		override public function transition(elapsed:Number):Boolean
		{
			threshold += (0xFFFFFF - threshold) * elapsed;
			perlin.threshold(perlin, perlin.rect, point, "<=", threshold, 0x00000000, 0x00FFFFFF, false);
			return threshold >= 0xDFFFFF;
		}
		
		
		override public function render(render:RenderContext):void
		{
			render.buffer.copyPixels(dst, dst.rect, point);
			render.buffer.copyPixels(src, src.rect, point, perlin, null, true);
		}
		
		
		override public function shutdown():void
		{
			perlin.dispose();
			
			perlin = null;
			point  = null;
		}
		
	}

}
