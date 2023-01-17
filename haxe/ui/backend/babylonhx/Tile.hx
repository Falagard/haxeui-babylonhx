package haxe.ui.backend.babylonhx;

class Tile {
	/**
		Creates a new Texture from provided BitmapData and returns a Tile representing it.
	**/
	public static function fromBitmap( bmp : ImageData ) : Tile {
        return null;
    }

    /**
		Create a sub-region of this Tile with specified size and offset.
		@param x The offset on top of the current Tile offset along the X axis.
		@param y The offset on top of the current Tile offset along the Y axis.
		@param w The width of the new Tile region. Can exceed current tile size.
		@param h The height of the new Tile region. Can exceed the current tile size.
		@param dx An optional visual offset of the new Tile along the X axis.
		@param dy An optional visual offset of the new Tile along the Y axis.
	**/
	public function sub( x : Float, y : Float, w : Float, h : Float, dx = 0., dy = 0. ) : Tile {
		return null;
	}
}