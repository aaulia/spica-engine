package spica.math
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class MathRng
	{
		private static var seed:uint = Math.random() * uint.MAX_VALUE;
		
		
		public static function randomize(s:uint):void
		{
			seed = s;
		}
		
		
		public static function random():Number
		{
			seed ^= (seed <<  21);
			seed ^= (seed >>> 35);
			seed ^= (seed <<   4);
			
			return seed * 2.3283064370807973754314699618685e-10;
		}
		
	}

}
