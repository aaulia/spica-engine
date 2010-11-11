package spica.utility
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public final class ContextMenuManager
	{
		private var parent :DisplayObjectContainer = null;
		private var context:ContextMenu            = new ContextMenu();
		private var itemMap:Dictionary             = new Dictionary();
		private var itemFun:Vector.<Function>      = new Vector.<Function>();

		
		public function ContextMenuManager(parent:DisplayObjectContainer)
		{
			initialize(parent);
		}
		
		
		public function get quality():Boolean { return context.builtInItems.quality; }
		public function set quality(v:Boolean):void
		{
			context.builtInItems.quality = v;
		}
		
		
		private function initialize(parent:DisplayObjectContainer):void
		{
			this.parent                         = parent;
			this.parent.contextMenu             = context;
			
			context.builtInItems.forwardAndBack = false;
			context.builtInItems.play           = false;
			context.builtInItems.loop           = false;
			context.builtInItems.print          = false;
			context.builtInItems.rewind         = false;
			context.builtInItems.save           = false;
			context.builtInItems.zoom           = false;
		}
		
		
		public function addContextItem(caption:String, callback:Function):void
		{
			var item:ContextMenuItem = new ContextMenuItem(caption);
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuItemSelect);
			if (itemMap[ caption ] == null)
			{
				context.customItems.push(item);
				itemFun.push(callback);
				itemMap[ caption ] = item;
			}
			else
			{
				var index:int = context.customItems.indexOf(itemMap[ caption ]);
				context.customItems[  index  ] = item;
				itemFun            [  index  ] = callback;
				itemMap            [ caption ] = item;
			}
			
		}
		
		
		public function delContextItem(caption:String):void
		{
			var index:int = context.customItems.indexOf(itemMap[ caption ]);
			context.customItems.splice(index, 1);
			itemFun.splice(index, 1);
			itemMap[ caption ] = null;
		}
		
		
		public function getContextItem(caption:String):ContextMenuItem
		{
			return itemMap[ caption ];
		}
		
		
		private function onMenuItemSelect(e:ContextMenuEvent):void
		{
			var itemIndex:int = context.customItems.indexOf(e.currentTarget);
			if (itemFun[ itemIndex ])
				itemFun[ itemIndex ]();
				
		}
		
	}

}
