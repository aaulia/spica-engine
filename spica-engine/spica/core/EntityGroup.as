package spica.core
{
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class EntityGroup extends Entity
	{
		public var members:Vector.<Entity> = new Vector.<Entity>();
		
		
		public function add(entity:Entity):Entity
		{
			var exist:int = members.indexOf(entity);
			if (exist < 0)
				members.push(entity);
				
			return entity;
		}
		
		
		public function remove(entity:Entity):Entity
		{
			var exist:int = members.indexOf(entity);
			if (exist >= 0)
				members.splice(exist, 1);
			
			return entity;
		}
		
		
		public function getFirstDead():Entity
		{
			var length:int = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				if (!members[ i ].isAlive)
					return members[ i ];
					
			}
			
			return null;
		}
		
		
		public function get deadCount():int
		{
			var count :int = 0;
			var length:int = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				if (!members[ i ].isAlive)
					++count;
					
			}
			
			return count;
		}
		
		
		public function get aliveCount():int
		{
			var count :int = 0;
			var length:int = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				if (members[ i ].isAlive)
					++count;
					
			}
			
			return count;
		}
		
		
		override public function onTick():void
		{
			var entity:Entity = null;
			var length:int    = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				entity = members[ i ];
				if (entity.isAlive && entity.isActive)
					entity.onTick();
					
			}
			
		}
		
		
		override public function update(elapsed:Number):void
		{
			var entity:Entity = null;
			var length:int    = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				entity = members[ i ];
				if (entity.isAlive && entity.isActive)
					entity.update(elapsed);
					
			}
			
		}
		
		
		override public function render(context:RenderContext):void
		{
			var entity:Entity = null;
			var length:int    = members.length;
			for (var i:int = 0; i < length; ++i)
			{
				entity = members[ i ];
				if (entity.isAlive && entity.isVisible)
					entity.render(context);
					
			}
			
		}
		
		
		override public function shutdown():void
		{
			var entity:Entity = null;
			var length:int    = members.length;
			for (var i:int = 0; i < length; ++i)
				members[ i ].shutdown();
			
		}
		
	}

}
