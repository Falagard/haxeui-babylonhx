package haxe.ui.backend.babylonhx;

class Graphics {


    /**
		The Tile used as source of Texture to render.
	**/
	public var tile : Tile;

    /**
		Create a new Graphics instance.
		@param parent An optional parent `h2d.Object` instance to which Graphics adds itself if set.
	**/
	public function new() {
		tile = null; //h2d.Tile.fromColor(0xFFFFFF);
		clear();
	}

    /**
		Clears the Graphics contents.
	**/
	public function clear() {

    }

    /**
		Position a virtual tile at the given position and scale. Every draw will display a part of this tile relative
		to these coordinates.

		Note that in by default, Tile is not wrapped, and in order to render tiling texture, `Drawable.tileWrap` have to be set.
		Additionally, both `Tile.dx` and `Tile.dy` are ignored (use `dx`/`dy` arguments instead)
		as well as tile defined size of the tile through `Tile.width` and `Tile.height` (use `scaleX`/`scaleY` relative to texture size).

		Beginning new fill will finish previous fill operation without need to call `Graphics.endFill`.

		@param dx An X offset of the Tile relative to Graphics.
		@param dy An Y offset of the Tile relative to Graphics.
		@param scaleX A horizontal scale factor applied to the Tile texture.
		@param scaleY A vertical scale factor applied to the Tile texture.
		@param tile The tile to fill with. If null, uses previously used Tile with `beginTileFill` or throws an error.
		Previous tile is remembered across `Graphics.clear` calls.
	**/
    public function beginTileFill( ?dx : Float, ?dy : Float, ?scaleX : Float, ?scaleY : Float, ?tile : Tile ) {

    }

    /**
		Sets an outline style. Changing the line style ends the currently drawn line.

		@param size Width of the outline. Setting size to 0 will remove the outline.
		@param color An outline RGB color.
		@param alpha An outline transparency.
	**/
	public function lineStyle( size : Float = 0, color = 0, alpha = 1. ) {

    }

    	/**
		Begins a solid color fill.

		Beginning new fill will finish previous fill operation without need to call `Graphics.endFill`.

		@param color An RGB color with which to fill the drawn shapes.
		@param alpha A transparency of the fill color.
	**/
	public function beginFill( color : Int = 0, alpha = 1.  ) {

    }

    /**
		Ends the current fill operation.
	**/
	public function endFill() {

    }

    /**
		Draws a rectangle with given parameters.
		@param x The rectangle top-left corner X position.
		@param y The rectangle top-left corner Y position.
		@param w The rectangle width.
		@param h The rectangle height.
	**/
	public function drawRect( x : Float, y : Float, w : Float, h : Float ) {

    }

    /**
		Draws a straight line from the current drawing position to the given position.
	**/
	public inline function lineTo( x : Float, y : Float ) {

    }

    function flush() {

    }

}

