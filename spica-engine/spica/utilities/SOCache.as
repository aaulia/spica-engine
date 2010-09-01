package spica.utilities 
{
	import flash.errors.IllegalOperationError;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class SOCache
	{
		private static var guardFlag:Boolean = false;
		private static var _instance:SOCache = null;
		public static function get instance():SOCache
		{
			if (_instance == null)
			{
				guardFlag = false;
				_instance = new SOCache();
				guardFlag = true;
			}
			
			return _instance;
		}
		
		
		private var cache:Object       = new Object();
		private var id   :String       = "";
		private var SO   :SharedObject = null;
		
		
		public function get active  ():SharedObject { return SO; }
		public function get activeId():String       { return id; }
		
		
		public function SOCache() 
		{
			if (!guardFlag)
				throw new IllegalOperationError("You should not instantiate a Singleton Class");
				
		}
		
		
		public function setup(id:String):void 
		{
			this.id = id;
			this.SO = cache[ id ] = SharedObject.getLocal(id);
		}
		
		
		public function setTo(id:String):Boolean
		{
			if (cache[ id ] != null)
			{
				this.id = id;
				this.SO = cache[ id ];
				return true;
			}
			
			return false;
		}
		
		
		public function apply():Boolean
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