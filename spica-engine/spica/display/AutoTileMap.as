package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;

	import spica.core.Camera;
	import spica.core.RenderContext;

	public class AutoTileMap extends TileMap
	{
		public function AutoTileMap(map:XML = null, tileSets:Class = null, layerName:String = "")
		{
			super(map, tileSets, layerName);
		}


		private const TOP:int   = 1;
		private const DOWN:int  = 2;
		private const LEFT:int  = 4;
		private const RIGHT:int = 8;
		private const SETS:int  = 16;


		public override function render(context:RenderContext):void
		{
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

					sprite.frame = ((tid - 1) * SETS) + calcAutoTileFrame(i, j);
					sprite.x = posX;
					sprite.y = posY;
					sprite.render(context);
				}

			}

		}


		protected function calcAutoTileFrame(i:int, j:int):int
		{
			var t:int = j - 1;
			var d:int = j + 1;
			var l:int = i - 1;
			var r:int = i + 1;
			var f:int = 0;

			if (t >= 0 && t < mapHeight && data[i + t * mapWidth])
				f += TOP;
			if (d >= 0 && d < mapHeight && data[i + d * mapWidth])
				f += DOWN;
			if (l >= 0 && l < mapWidth && data[l + j * mapWidth])
				f += LEFT;
			if (r >= 0 && r < mapWidth && data[r + j * mapWidth])
				f += RIGHT;

			return f;
		}

	}

}