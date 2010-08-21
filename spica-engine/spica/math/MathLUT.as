package spica.math
{
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class MathLUT
	{
		public static const DEG_TO_RAD:Number =  0.017453292519943295769236907684886;
		public static const RAD_TO_DEG:Number = 57.295779513082320876798154814105;
		
		public static const sin:Vector.<Number> = new Vector.<Number>(2880, true);
		public static const cos:Vector.<Number> = new Vector.<Number>(2880, true);

		
		
		private static const initialize:Boolean = doInitialize();
		private static function doInitialize():Boolean
		{
			var angle:Number = 0.0;
			for (var i:int = 0; i < 2880; ++i)
			{
				angle    = i / 8 * DEG_TO_RAD;
				sin[ i ] = Math.sin(angle);
				cos[ i ] = Math.cos(angle);
			}
		
			return true;
		}
		
	}

}
