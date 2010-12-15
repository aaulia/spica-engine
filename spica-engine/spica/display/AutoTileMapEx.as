package spica.display
{
	import flash.display.BitmapData;
	
	import spica.core.Camera;
	import spica.core.RenderContext;

	public class AutoTileMapEx extends TileMap
	{
		public function AutoTileMapEx(mapWidth:int, mapHeight:int)
		{
			super(mapWidth, mapHeight);
		}

		override public function setTileSet(tileSet:Class, tileWidth:int, tileHeight:int):void
		{
			sprite.load(tileSets, tileWidth / 2, tileHeight / 2);
			sprite.scrollX  = 0;
			sprite.scrollY  = 0;
			
			this.tileWidth  = tileWidth;
			this.tileHeight = tileHeight;
			this.width      = this.mapWidth  * tileWidth;
			this.height     = this.mapHeight * tileHeight;
		}
		
		
		public override function render(context:RenderContext):void
		{
			if (data.lengt == 0 || sprite.frameCount == 0)
				return;
			
			var scr:BitmapData = context.buffer;
			var cam:Camera     = context.camera;
			
			if (scr == null)
				return;
			
			calcRenderPos(cam, point);
			
			if (point.x < -width || point.y < -height || point.x > scr.width || point.y > scr.height)
				return;
			
			var posX:int = int(point.x);
			var posY:int = int(point.y);
			
			for (var j:int = 0; j < mapHeight; ++j)
			{
				posY = point.y + (j * tileHeight);
				if (posY < -tileHeight)
					continue;
				if (posY > scr.height)
					break;
				
				var ri:int = j * mapWidth;
				for (var i:int = 0; i < mapWidth; ++i)
				{
					posX = point.x + (i * tileWidth);
					if (posX < -tileWidth)
						continue;
					if (posX > scr.width)
						break;
					
					var tid:int = data[i + ri];
					if (tid == 0)
						continue;
					
					for (var r:int = 0; r < 2; ++r)
					{
						sprite.y = posY + (r * (tileHeight / 2));
						for (var c:int = 0; c < 2; ++c)
						{
							sprite.x     = posX + (c * (tileWidth / 2));
							sprite.frame = calcAutoTileFrame(i, j, c, r);
							sprite.render(context);
						}
					}
				}
			}
		}
	
		
		protected function calcAutoTileFrame(i:int, j:int, c:int, r:int):int
		{
			var x:int = i + (c == 0 ? -1 : 1);
			var y:int = j + (r == 0 ? -1 : 1);
			var h:int = (x < 0 || x >= mapWidth)  ? 1 : data[x + j * mapWidth];
			var v:int = (y < 0 || y >= mapHeight) ? 1 : data[i + y * mapWidth];
			var f:int = 0;
			
			f = v + (2 * h);
			
			if (f == 3)
				if (x < 0 || x >= mapWidth || y < 0 || y >= mapHeight || data[x + y * mapWidth])
					++f;
				
			return ((f * 2) + c) + (r * 10);
		}
		
	}
}
