package haxe.ui.backend.babylonhx;

import haxe.display.JsonModuleTypes.JsonTypeParameters;
import haxe.xml.Access;

class Texture {
	
	public var width(default, null) : Int;
	public var height(default, null) : Int;
}

class Tile {

	var innerTex : Texture;

	/**
		Horizontal position of the Tile on the Texture.

		Cannot be modified directly, use `Tile.setPosition` instead.
	**/
	public var x(default,null) : Float;
	/**
		Vertical position of the Tile on the Texture.

		Cannot be modified directly, use `Tile.setPosition` instead.
	**/
	public var y(default,null) : Float;

    public function new() {
		
    }

	/**
		Creates a new Texture from provided BitmapData and returns a Tile representing it.
	**/
	public static function fromBitmap( bmp : ImageData ) : Tile {
        return new Tile();
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
		return new Tile();
	}

	/**
		Create a solid color Tile with specified width, height, color and alpha.
		@param color The RGB color of the Tile.
		@param width The width of the Tile in pixels.
		@param height The height of the Tile in pixels.
		@param alpha The transparency of the Tile.
	**/
	public static function fromColor( color : Int, ?width = 1, ?height = 1, ?alpha = 1. ) : Tile {
		//var t = new Tile(h3d.mat.Texture.fromColor(color,alpha),0,0,1,1);
		var t = new Tile();
		// scale to size
		//t.width = width;
		//t.height = height;
		return t;
	}

	/**
		Returns an underlying Texture instance.
	**/
	public inline function getTexture():Texture {
		return innerTex;
	}
}