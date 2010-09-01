package spica.core
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class ShaderManager
	{
		private var shaders:Vector.<Shader> = null;
		
		
		public function ShaderManager()
		{
			shaders = new Vector.<Shader>();
		}
		
		
		public function push(shader:Shader):ShaderManager
		{
			shaders.push(shader);
			return this;
		}
		
		
		public function pop():Shader
		{
			return shaders.pop();
		}
		
		
		public function preRender(render:RenderContext):void
		{
			var buffer:BitmapData = render.buffer;
			var shader:Shader     = null;
			var length:int        = shaders.length;
			
			for (var i:int; i < length; ++i)
			{
				shader = shaders[ i ];
				if (shader.isActive)
					shader.preRender(buffer);
			}
				
		}
		
		
		public function postRender(render:RenderContext):void
		{
			var buffer:BitmapData = render.buffer;
			var shader:Shader     = null;
			var length:int        = shaders.length;
			
			for (var i:int; i < length; ++i)
			{
				shader = shaders[ i ];
				if (shader.isActive)
					shader.postRender(buffer);
			}
			
		}
		
		
		public function shutdown():void
		{
			var length:int = shaders.length;
			for (var i:int; i < length; ++i)
				shaders[ i ].shutdown();
			
			shaders = new Vector.<Shader>();
		}
		
	}

}
