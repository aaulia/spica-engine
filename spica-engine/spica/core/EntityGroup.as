package spica.core
{
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class EntityGroup extends Entity
	{
		public var members:/*Entity*/Array = [];
		
		
		public function add(entity:Entity):EntityGroup
		{
			var exist:int = members.indexOf(entity);
			if (exist < 0)
				members.push(entity);
				
			return this;
		}
		
		
		public function remove(entity:Entity):EntityGroup
		{
			var exist:int = members.indexOf(entity);
			if (exist >= 0)
				members.splice(exist, 1);
			
			return this;
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
			var length:int    = members.length;
			for (var i:int = 0; i < length; ++i)
				members[ i ].shutdown();
			
		}
		
	}

}
