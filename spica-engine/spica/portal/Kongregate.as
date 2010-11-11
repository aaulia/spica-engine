package spica.portal
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class Kongregate
	{
		private static const LOCAL_API_PATH:String     = "http://www.kongregate.com/flash/API_AS3_Local.swf";
		
		
		private static var kongregate:Object   = null;
		private static var callback  :Function = null;
		
		
		private static function onComplete(e:Event):void
		{
			LoaderInfo(e.target).removeEventListener(Event.COMPLETE, onComplete, false);
			kongregate = Object(e.target.content);
			
			if (callback != null)
				callback();
				
		}
		
		
		public static function initialize(parent:DisplayObjectContainer, callback:Function = null):void
		{
			var path:String = String(LoaderInfo(parent.root.loaderInfo).parameters.kongregate_api_path);
			if (path == "" || path == "undefined" || path == null)
				path = LOCAL_API_PATH;
			
			Security.allowDomain(path);
			
			var loader:Loader     = parent.addChild(new Loader()) as Loader;
			var urlReq:URLRequest = new URLRequest(path);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			loader.load(urlReq);
			
			Kongregate.callback   = callback;
		}
		
		
		/** General Services API */
		public static function     connect      ():void    { kongregate.services.connect();                 }
		public static function     showSignInBox():void    { kongregate.services.showSignInBox();           }
		public static function get isGuest      ():Boolean { return kongregate.services.isGuest();          }
		public static function get username     ():String  { return kongregate.services.getUsername();      }
		public static function get userId       ():String  { return kongregate.services.getUserId();        }
		public static function get gameAuthToken():String  { return kongregate.services.getGameAuthToken(); }
		
		
		/** Statistics API */
		public static function submit(statName:String, value:Number):void
		{
			kongregate.stats.submit(statName, value);
		}
		
		
		/** Avatar Export */
		public static function submitAvatar(avatar:DisplayObject, callback:Function):void
		{
			kongregate.images.submitAvatar(avatar, callback);
		}
		
		
		/** Chat Integration */
		/** Microtransactions */
		/** Shared Conntent */
		
	}

}
