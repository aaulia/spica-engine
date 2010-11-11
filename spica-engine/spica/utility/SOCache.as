package spica.utility
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class SOCache
	{
		public static function get active  ():Object { return SO.data; }
		public static function get activeId():String { return id; }
		
		
		private static var cache:Object       = new Object();
		private static var id   :String       = "";
		private static var SO   :SharedObject = null;
		
		
		public static function setup(id:String):void
		{
			SOCache.id = id;
			SOCache.SO = cache[ id ] = SharedObject.getLocal(id);
		}
		
		
		public static function setTo(id:String):Boolean
		{
			if (cache[ id ] != null)
			{
				SOCache.id = id;
				SOCache.SO = cache[ id ];
				return true;
			}
			
			return false;
		}
		
		
		public static function apply():Boolean
		{
			if (SO != null)
			{
				SO.flush();
				return true;
			}
			
			return false;
		}
		
	}

}
