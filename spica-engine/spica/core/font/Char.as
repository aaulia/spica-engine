package spica.core.font
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class Char
	{
		public var rect:Rectangle = null;	/** read-only */
		public var xOff:int       = 0;		/** read-only */
		public var yOff:int       = 0;		/** read-only */
		public var xAdv:int       = 0;		/** read-only */
		
		
		public function Char( 
			rect:Rectangle,
			xOff:int,
			yOff:int,
			xAdv:int)
		{
			this.rect = rect;
			this.xOff = xOff;
			this.yOff = yOff;
			this.xAdv = xAdv;
		}
		
		
		public function toString():String
		{
			return "[Char rect=" + rect + " xOff=" + xOff + " yOff=" + yOff + " xAdv=" + xAdv + "]";
		}
		
	}

}
