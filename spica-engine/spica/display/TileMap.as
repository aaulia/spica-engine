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

		
		private var data      :Vector.<int> = new Vector.<int>();
		private var sprite    :Sprite       = new Sprite();
		private var point     :Point        = new Point();
		
		
		public function TileMap(map:XML = null, tileSets:Class = null, layerName:String = "")
		{
			if (map && tileSets && layerName)
				loadFromXML(map, layerName, tileSets);
				
		}
		
		
		public function loadFromVector
			( data      :Vector.<int>
			, tileWidth :int
			, tileHeight:int
			, mapWidth  :int
			, mapHeight :int
			, tileSets  :Class):void
		{
			/**
			 * load map data
			 */
			this.tileWidth  = tileWidth;
			this.tileHeight = tileHeight;
			this.mapWidth   = mapWidth;
			this.mapHeight  = mapHeight;
			this.data       = data.concat();
			
			this.width      = mapWidth  * tileWidth;
			this.height     = mapHeight * tileHeight;
			
			/**
			 * load tileset
			 */
			sprite.load(tileSets, tileWidth, tileHeight);
			sprite.scrollX = 0;
			sprite.scrollY = 0;
		}
		
		
		public function loadFromXML
			( map      :XML
			, layerName:String
			, tileSets :Class):void
		{
			if (map == null || tileSets == null || layerName == "")
				throw "Invalid loading parameters, map: " + map + ", tilesets: " + tileSets + ", layerName: " + layerName;
			
			/**
			 * parse map data
			 */
			var layer:XMLList = map.layer.(@name == layerName);
			if (layer)
			{
				loadFromVector
					( vectorFromXml(layer.data.tile)
					, int(map.@tilewidth)
					, int(map.@tileheight)
					, int(layer.@width)
					, int(layer.@height)
					, tileSets );
				
			}
			else
				throw "Layer " + layerName + " not found!";
				
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
