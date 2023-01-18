package haxe.ui.backend.babylonhx;

class Earcut {

    var triangles : Array<Int>;

    public function new() {
	}

	@:generic public function triangulate < T: { x:Float, y:Float } > ( points : Array<T>, ?holes : Array<Int> ) : Array<Int> {
        triangles = [];
        var result = triangles;
        return result;
	}
}