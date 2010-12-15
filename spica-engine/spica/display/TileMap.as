package spica.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.xml.XMLTag;
	import spica.core.Camera;
	import spica.core.RenderContext;
	/**
	 * ...
	 * @author Achmad Aulia Noorhakim
	 */
	public class TileMap extends Visual
	{
		public  var mapWidth  :int          = 0; 	/** read-only */
		public  var mapHeight :int          = 0; 	/** read-only */
		
		
		public  var tileWidth :int          = 0; 	/** read-only */
		public  var tileHeight:int          = 0; 	/** read-only */

		
		protected var data    :Vector.<int> = new Vector.<int>();
		protected var sprite  :Sprite       = new Sprite();
		protected var point   :Point        = new Point();
		
		
		public function TileMap(mapWidth:int, mapHeight:int)
		{
			if (mapWidth && mapHeight)
				initialize(mapWidth, mapHeight);
		}
		
		public function initialize(mapWidth:int, mapHeight:int):void
		{
			this.mapWidth  = mapWidth;
			this.mapHeight = mapHeight;
			this.width     = mapWidth  * this.tileWidth;
			this.height    = mapHeight * this.tileHeight;
			
			var total:int = mapWidth * mapHeight;
			data = new Vector.<int>();
			for (var i:int = 0; i < total; ++i)
				data[ i ] = 0;
				
		}
		
		public function setTileSet(tileSet:Class, tileWidth:int, tileHeight:int):void
		{
			sprite.load(tileSet, tileWidth, tileHeight);
			sprite.scrollX  = 0;
			sprite.scrollY  = 0;
			
			this.tileWidth  = tileWidth;
			this.tileHeight = tileHeight;
			this.width      = this.mapWidth  * tileWidth;
			this.height     = this.mapHeight * tileHeight;
		}
		
		public function loadFromVector(
			data      :Vector.<int>,
			mapWidth  :int,
			mapHeight :int ):void
		{
			this.data      = data.concat();
			this.mapWidth  = mapWidth;
			this.mapHeight = mapHeight;
			this.width     = mapWidth  * this.tileWidth;
			this.height    = mapHeight * this.tileHeight;
		}
		
		
		public function loadFromXML(
			map      :XML,
			layerName:String ):void
		{
			if (map == null || layerName == "")
				throw "Invalid loading parameters, map: " + map + ", layerName: " + layerName;
			
			/**
			 * parse map data
			 */
			var layer:XMLList = map.layer.(@name == layerName);
			if (layer)
				loadFromVector(vectorFromXml(layer.data.tile), int(layer.@width), int(layer.@height));
			else
				throw Error("Layer " + layerName + " not found!");
				
		}
		
		
		private function vectorFromXml(tilesXml:XMLList):Vector.<int>
		{
			var r:Vector.<int> = new Vector.<int>();
			var i:int          = 0;
			for each (var tile:XML in tilesXml)
				r[ i++ ] = int(tile.@gid);

			return r;
		}
		
		
		public function getTile(x:int, y:int)       :int  { return data[ x + y * mapWidth ]; }
		public function setTile(x:int, y:int, v:int):void { data[ x + y * mapWidth ] = v; }
		
		
		override public function render(context:RenderContext):void
		{
			if (data.length == 0 || sprite.frameCount == 0)
				return;
			
			var scr:BitmapData = context.buffer;
			var cam:Camera     = context.camera;
			
			if (scr == null)
				return;
				
			calcRenderPos(cam, point);
			
			if (point.x < -width || point.y < -height || point.x > scr.width || point.y > scr.height)
				return;
				
			var posX  :int = int(point.x);
			var posY  :int = int(point.y);
			
			for (var j:int = 0; j < mapHeight; ++j)
			{
				posY = point.y + (j * tileHeight);
				if (posY < -tileHeight) continue;
				if (posY >  scr.height) break;
				
				var ri:int = j * mapWidth;
				for (var i:int = 0; i < mapWidth; ++i)
				{
					posX = point.x + (i * tileWidth);
					if (posX < -tileWidth) continue;
					if (posX >  scr.width) break;
					
					var tid:int = data[ i + ri ];
					if (tid == 0) continue;
					
					sprite.frame = tid - 1;
					sprite.x     = posX;
					sprite.y     = posY;
					sprite.render(context);
				}
				
			}
			
		}
		
		
		override public function dispose():void
		{
			if (sprite != null)
				sprite.dispose();
				
			sprite = null;
			data   = null;
			point  = null;
		}
	}

}
