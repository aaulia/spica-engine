package spica.core
{
	import flash.events.ActivityEvent;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class EntityGroup extends Entity
	{
		protected var nodes:Vector.<Entity> = new Vector.<Entity>();
		
		
		public function get numAlive():int
		{
			var count :int = 0;
			var length:int = nodes.length;
			for (var i:int = 0; i < length; ++i)
				if (nodes[ i ].alive)
					++count;
					
			
			return count;
		}
		
		
		public function get numDead():int
		{
			var count :int = 0;
			var length:int = nodes.length;
			for (var i:int = 0; i < length; ++i)
				if (!nodes[ i ].alive)
					++count;
					
			
			return count;
		}
		
		
		public function getFirstDead():Entity
		{
			var length:int = nodes.length;
			for (var i:int = 0; i < length; ++i)
				if (!nodes[ i ].alive)
					return nodes[ i ];
				
			
			return null;
		}
		
		
		public function add(entity:Entity):Entity
		{
			if (nodes.indexOf(entity) < 0)
				nodes[ nodes.length ] = entity;
			
			return entity;
		}
		
		
		public function del(entity:Entity):Entity
		{
			var index:int = nodes.indexOf(entity);
			if (index >= 0)
				nodes.splice(index, 1);
				
			return entity;
		}
		
		
		override public function step():void
		{
			var length:int    = nodes.length;
			var entity:Entity = null;
			
			for (var i:int = 0; i < length; ++i)
			{
				entity = nodes[ i ];
				if (entity.alive && entity.active)
					entity.step();
					
			}
				
		}
		
		
		override public function update(elapsed:int):void
		{
			var length:int    = nodes.length;
			var entity:Entity = null;
			
			for (var i:int = 0; i < length; ++i)
			{
				entity = nodes[ i ];
				if (entity.alive && entity.active)
					entity.update(elapsed);
					
			}
			
		}
		
		
		override public function render(context:RenderContext):void
		{
			var length:int    = nodes.length;
			var entity:Entity = null;
			
			for (var i:int = 0; i < length; ++i)
			{
				entity = nodes[ i ];
				if (entity.alive && entity.visible)
					entity.render(context);
					
			}
			
		}
		
		
		override public function dispose():void
		{
			var length:int = nodes.length;
			for (var i:int = 0; i < length; ++i)
				nodes[ i ].dispose();
				
		}
		
		
		public static function operateOn(a:EntityGroup, b:EntityGroup, func:Function, oneTime:Boolean = false):void
		{
			var anode:Vector.<Entity> = a.nodes;
			var asize:int             = anode.length;
			var ainst:Entity          = null;
			
			var bnode:Vector.<Entity> = b.nodes;
			var bsize:int             = bnode.length;
			var binst:Entity          = null;
			
			for (var i:int = 0; i < asize; ++i)
			{
				ainst = anode[ i ];
				if (!ainst || !ainst.alive)
					continue;
				
				for (var j:int = 0; j < bsize; ++j)
				{
					binst = bnode[ j ];
					if (!binst || !binst.alive)
						continue;
						
					func(ainst, binst);
					
					if (!ainst.alive || oneTime)
						break;
						
				}
				
			}
			
		}
		
	}

}
