package haxe.ui.backend.babylonhx;

import com.babylonhx.utils.typedarray.UInt32Array;
import com.babylonhx.utils.typedarray.Float32Array;
import com.babylonhx.mesh.VertexBuffer;
import com.babylonhx.mesh.Buffer;
import com.babylonhx.mesh.WebGLBuffer;
import com.babylonhx.ui.UIComponent;

@:dox(hide)
class GPoint {
	public var x : Float;
	public var y : Float;
	public var r : Float;
	public var g : Float;
	public var b : Float;
	public var a : Float;

	public function new() {
	}

	public function load(x, y, r, g, b, a ){
		this.x = x;
		this.y = y;
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}
}

private class GraphicsContent {

	//private var _vertexData:Float32Array; //the pure float array including all vertex data, positions, color, etc.
	//private var _vertexBuffer:Buffer; //the buffer that rests over top of the vertex data
	//private var _vertexBuffers:Map<String, VertexBuffer> = new Map(); //a map of kind strings to vertex buffers
	//private var _indexBuffer:WebGLBuffer; //index buffer

	//var tmp : hxd.FloatBuffer;
	//var index : hxd.IndexBuffer;
	//var state : BatchDrawState;

	//var buffers : Array<{ buf : hxd.FloatBuffer, vbuf : h3d.Buffer, idx : hxd.IndexBuffer, ibuf : h3d.Indexes, state : BatchDrawState }>;
	//var bufferDirty : Bool;
	//var indexDirty : Bool;
	#if track_alloc
	//var allocPos : hxd.impl.AllocPos;
	#end

	public function new() {
		//buffers = [];
		//state = new BatchDrawState();
		#if track_alloc
		//this.allocPos = new hxd.impl.AllocPos();
		#end
	}

	public inline function addIndex(i) {
		//index.push(i);
		//state.add(1);
		//indexDirty = true;
	}

	public inline function add( x : Float, y : Float, u : Float, v : Float, r : Float, g : Float, b : Float, a : Float ) {
		// tmp.push(x);
		// tmp.push(y);
		// tmp.push(u);
		// tmp.push(v);
		// tmp.push(r);
		// tmp.push(g);
		// tmp.push(b);
		// tmp.push(a);
		// bufferDirty = true;
	}

	public function setTile( tile : Tile ) {
		//state.setTile(tile);
	}

	public function next() {
		// var nvect = tmp.length >> 3;
		// if( nvect < 1 << 15 )
		// 	return false;
		// buffers.push( { buf : tmp, idx : index, vbuf : null, ibuf : null, state: state } );
		// tmp = new hxd.FloatBuffer();
		// index = new hxd.IndexBuffer();
		// var tex = state.currentTexture;
		// state = new BatchDrawState();
		// state.setTexture(tex);
		// super.dispose();
		return true;
	}

	// override function alloc( engine : h3d.Engine ) {
	// 	if (index.length <= 0) return ;
	// 	var alloc = Allocator.get();
	// 	buffer = alloc.ofFloats(tmp, 8, RawFormat);
	// 	#if track_alloc
	// 	@:privateAccess buffer.allocPos = allocPos;
	// 	#end
	// 	indexes = alloc.ofIndexes(index);
	// 	for( b in buffers ) {
	// 		if( b.vbuf == null || b.vbuf.isDisposed() ) b.vbuf = alloc.ofFloats(b.buf, 8, RawFormat);
	// 		if( b.ibuf == null || b.ibuf.isDisposed() ) b.ibuf = alloc.ofIndexes(b.idx);
	// 	}
	// 	bufferDirty = false;
	// 	indexDirty = false;
	// }

	// public function doRender( ctx : h2d.RenderContext ) {
	// 	if ( index.length == 0 ) return;
	// 	flush();
	// 	for ( b in buffers ) b.state.drawIndexed(ctx, b.vbuf, b.ibuf);
	// 	state.drawIndexed(ctx, buffer, indexes);
	// }

	public function flush() {
		// if( buffer == null || buffer.isDisposed() ) {
		// 	alloc(h3d.Engine.getCurrent());
		// } else {
		// 	var allocator = Allocator.get();
		// 	if ( bufferDirty ) {
		// 		allocator.disposeBuffer(buffer);
		// 		buffer = allocator.ofFloats(tmp, 8, RawFormat);
		// 		bufferDirty = false;
		// 	}
		// 	if ( indexDirty ) {
		// 		allocator.disposeIndexBuffer(indexes);
		// 		indexes = allocator.ofIndexes(index);
		// 		indexDirty = false;
		// 	}
		// }
	}

	// override function dispose() {
	// 	for( b in buffers ) {
	// 		if( b.vbuf != null ) Allocator.get().disposeBuffer(b.vbuf);
	// 		if( b.ibuf != null ) Allocator.get().disposeIndexBuffer(b.ibuf);
	// 		b.vbuf = null;
	// 		b.ibuf = null;
	// 		b.state.clear();
	// 	}

	// 	if( buffer != null ) {
	// 		Allocator.get().disposeBuffer(buffer);
	// 		buffer = null;
	// 	}
	// 	if( indexes != null ) {
	// 		Allocator.get().disposeIndexBuffer(indexes);
	// 		indexes = null;
	// 	}
	// 	state.clear();

	// 	super.dispose();
	// }


	public function clear() {
		// dispose();
		// tmp = new hxd.FloatBuffer();
		// index = new hxd.IndexBuffer();
		// buffers = [];
	}

}

/**
	A simple interface to draw arbitrary 2D geometry.

	Usage notes:
	* While Graphics allows for multiple unique textures, each texture swap causes a new drawcall,
	and due to that it's recommended to minimize the amount of used textures per Graphics instance,
	ideally limiting to only one texture.
	* Due to how Graphics operate, removing them from the active `h2d.Scene` will cause a loss of all data.
**/
class Graphics extends UIComponent {

	var content : GraphicsContent;
	var tmpPoints : Array<GPoint>;
	var pindex : Int;
	var curR : Float;
	var curG : Float;
	var curB : Float;
	var curA : Float;
	var lineSize : Float;
	var lineR : Float;
	var lineG : Float;
	var lineB : Float;
	var lineA : Float;
	var doFill : Bool;

	var xMin : Float;
	var yMin : Float;
	var xMax : Float;
	var yMax : Float;
	var xMinSize : Float;
	var yMinSize : Float;
	var xMaxSize : Float;
	var yMaxSize : Float;

	var ma : Float = 1.;
	var mb : Float = 0.;
	var mc : Float = 0.;
	var md : Float = 1.;
	var mx : Float = 0.;
	var my : Float = 0.;

    /**
		The Tile used as source of Texture to render.
	**/
	public var tile : Tile;

	/**
		Adds bevel cut-off at line corners.

		The value is a percentile in range of 0...1, dictating at which point edges get beveled based on their angle.
		Value of 0 being not beveled and 1 being always beveled.
	**/
	public var bevel = 0.25; //0 = not beveled, 1 = always beveled

    /**
	 * 
		Create a new Graphics instance.
	**/
	public function new() {
		super();
		content = new GraphicsContent();
		tile = Tile.fromColor(0xFFFFFF);
		clear();
	}

	public static inline function sqrt( f : Float ) {
		return std.Math.sqrt(f);
	}

	public static inline function invSqrt( f : Float ) {
		return 1. / sqrt(f);
	}

	public static inline function abs( f : Float ) {
		return f < 0 ? -f : f;
	}

    /**
		Clears the Graphics contents.
	**/
	public function clear() {
		content.clear();
		tmpPoints = [];
		pindex = 0;
		lineSize = 0;
		xMin = Math.POSITIVE_INFINITY;
		yMin = Math.POSITIVE_INFINITY;
		yMax = Math.NEGATIVE_INFINITY;
		xMax = Math.NEGATIVE_INFINITY;
		xMinSize = Math.POSITIVE_INFINITY;
		yMinSize = Math.POSITIVE_INFINITY;
		yMaxSize = Math.NEGATIVE_INFINITY;
		xMaxSize = Math.NEGATIVE_INFINITY;
    }

	function isConvex( points : Array<GPoint> ) {
		var first = true, sign = false;
		for( i in 0...points.length ) {
			var p1 = points[i];
			var p2 = points[(i + 1) % points.length];
			var p3 = points[(i + 2) % points.length];
			var s = (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x) > 0;
			if( first ) {
				first = false;
				sign = s;
			} else if( sign != s )
				return false;
		}
		return true;
	}


	function flushLine( start ) {
		var pts = tmpPoints;
		var last = pts.length - 1;
		var prev = pts[last];
		var p = pts[0];

		content.setTile(Tile.fromColor(0xFFFFFF));

		var closed = p.x == prev.x && p.y == prev.y;
		var count = pts.length;
		if( !closed ) {
			var prevLast = pts[last - 1];
			if( prevLast == null ) prevLast = p;
			var gp = new GPoint();
			gp.load(prev.x * 2 - prevLast.x, prev.y * 2 - prevLast.y, 0, 0, 0, 0);
			pts.push(gp);
			var pNext = pts[1];
			if( pNext == null ) pNext = p;
			var gp = new GPoint();
			gp.load(p.x * 2 - pNext.x, p.y * 2 - pNext.y, 0, 0, 0, 0);
			prev = gp;
		} else if( p != prev ) {
			count--;
			last--;
			prev = pts[last];
		}

		for( i in 0...count ) {
			var next = pts[(i + 1) % pts.length];

			var nx1 = prev.y - p.y;
			var ny1 = p.x - prev.x;
			var ns1 = invSqrt(nx1 * nx1 + ny1 * ny1);

			var nx2 = p.y - next.y;
			var ny2 = next.x - p.x;
			var ns2 = invSqrt(nx2 * nx2 + ny2 * ny2);

			var nx = nx1 * ns1 + nx2 * ns2;
			var ny = ny1 * ns1 + ny2 * ns2;
			var ns = invSqrt(nx * nx + ny * ny);

			nx *= ns;
			ny *= ns;

			var size = nx * nx1 * ns1 + ny * ny1 * ns1; // N.N1


			// *HACK* we should instead properly detect limits when the angle is too small
			if(size < 0.1) size = 0.1;


			var d = lineSize * 0.5 / size;
			nx *= d;
			ny *= d;

			if(size > bevel) {
				content.add(p.x + nx, p.y + ny, 0, 0, p.r, p.g, p.b, p.a);
				content.add(p.x - nx, p.y - ny, 0, 0, p.r, p.g, p.b, p.a);

				var pnext = i == last ? start : pindex + 2;

				if( i < count - 1 || closed ) {
					content.addIndex(pindex);
					content.addIndex(pindex + 1);
					content.addIndex(pnext);

					content.addIndex(pindex + 1);
					content.addIndex(pnext);
					content.addIndex(pnext + 1);
				}
				pindex += 2;
			}
			else {
				//bevel
				var n0x = next.x - p.x;
				var n0y = next.y - p.y;
				var sign = n0x * nx + n0y * ny;

				var nnx = -ny;
				var nny = nx;

				var size = nnx * nx1 * ns1 + nny * ny1 * ns1;
				var d = lineSize * 0.5 / size;
				nnx *= d;
				nny *= d;

				var pnext = i == last ? start : pindex + 3;

				if(sign > 0) {
					content.add(p.x + nx, p.y + ny, 0, 0, p.r, p.g, p.b, p.a);
					content.add(p.x - nnx, p.y - nny, 0, 0, p.r, p.g, p.b, p.a);
					content.add(p.x + nnx, p.y + nny, 0, 0, p.r, p.g, p.b, p.a);

					content.addIndex(pindex);
					content.addIndex(pnext);
					content.addIndex(pindex + 2);

					content.addIndex(pindex + 2);
					content.addIndex(pnext);
					content.addIndex(pnext + 1);
				}
				else {
					content.add(p.x + nnx, p.y + nny, 0, 0, p.r, p.g, p.b, p.a);
					content.add(p.x - nx, p.y - ny, 0, 0, p.r, p.g, p.b, p.a);
					content.add(p.x - nnx, p.y - nny, 0, 0, p.r, p.g, p.b, p.a);

					content.addIndex(pindex + 1);
					content.addIndex(pnext);
					content.addIndex(pindex + 2);

					content.addIndex(pindex + 1);
					content.addIndex(pnext);
					content.addIndex(pnext + 1);
				}

				content.addIndex(pindex);
				content.addIndex(pindex + 1);
				content.addIndex(pindex + 2);

				pindex += 3;
			}

			prev = p;
			p = next;
		}
		content.setTile(tile);
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
		if ( tile == null )
			tile = this.tile;
		if ( tile == null )
			throw "Tile not specified";
		flush();
		this.tile = tile;
		content.setTile(tile);
		setColor(0xFFFFFF);
		doFill = true;

		if( dx == null ) dx = 0;
		if( dy == null ) dy = 0;
		if( scaleX == null ) scaleX = 1;
		if( scaleY == null ) scaleY = 1;
		dx -= tile.x;
		dy -= tile.y;

		var tex = tile.getTexture();
		var pixWidth = 1 / tex.width;
		var pixHeight = 1 / tex.height;
		ma = pixWidth / scaleX;
		mb = 0;
		mc = 0;
		md = pixHeight / scaleY;
		mx = -dx * ma;
		my = -dy * md;
    }

    /**
		Sets an outline style. Changing the line style ends the currently drawn line.

		@param size Width of the outline. Setting size to 0 will remove the outline.
		@param color An outline RGB color.
		@param alpha An outline transparency.
	**/
	public function lineStyle( size : Float = 0, color = 0, alpha = 1. ) {
		flush();
		this.lineSize = size;
		lineA = alpha;
		lineR = ((color >> 16) & 0xFF) / 255.;
		lineG = ((color >> 8) & 0xFF) / 255.;
		lineB = (color & 0xFF) / 255.;
    }

    	/**
		Begins a solid color fill.

		Beginning new fill will finish previous fill operation without need to call `Graphics.endFill`.

		@param color An RGB color with which to fill the drawn shapes.
		@param alpha A transparency of the fill color.
	**/
	public function beginFill( color : Int = 0, alpha = 1.  ) {
		flush();
		tile = Tile.fromColor(0xFFFFFF);
		content.setTile(tile);
		setColor(color,alpha);
		doFill = true;
    }

    /**
		Ends the current fill operation.
	**/
	public function endFill() {
		flush();
		doFill = false;
    }

	/**
		Changes current fill color.
		Does not interrupt current fill operation and can be utilized to customize color per vertex.
		During tile fill operation, color serves as a tile color multiplier.
		@param color The new fill color.
		@param alpha The new fill transparency.
	**/
	public inline function setColor( color : Int, alpha : Float = 1. ) {
		curA = alpha;
		curR = ((color >> 16) & 0xFF) / 255.;
		curG = ((color >> 8) & 0xFF) / 255.;
		curB = (color & 0xFF) / 255.;
	}

    /**
		Draws a rectangle with given parameters.
		@param x The rectangle top-left corner X position.
		@param y The rectangle top-left corner Y position.
		@param w The rectangle width.
		@param h The rectangle height.
	**/
	public function drawRect( x : Float, y : Float, w : Float, h : Float ) {
		flush();
		lineTo(x, y);
		lineTo(x + w, y);
		lineTo(x + w, y + h);
		lineTo(x, y + h);
		lineTo(x, y);
		var e = 0.01; // see #776
		tmpPoints[0].x += e;
		tmpPoints[0].y += e;
		tmpPoints[1].y += e;
		tmpPoints[3].x += e;
		tmpPoints[4].x += e;
		tmpPoints[4].y += e;
		flush();
    }

    /**
		Draws a straight line from the current drawing position to the given position.
	**/
	public inline function lineTo( x : Float, y : Float ) {
		addVertex(x, y, curR, curG, curB, curA, x * ma + y * mc + mx, x * mb + y * md + my);
    }

	/**
		Advanced usage. Adds new vertex to the current polygon with given parameters and current line style.
		@param x Vertex X position
		@param y Vertex Y position
		@param r Red tint value of the vertex when performing fill operation.
		@param g Green tint value of the vertex when performing fill operation.
		@param b Blue tint value of the vertex when performing fill operation.
		@param a Alpha of the vertex when performing fill operation.
		@param u Normalized horizontal Texture position from the current Tile fill operation.
		@param v Normalized vertical Texture position from the current Tile fill operation.
	**/
	public function addVertex( x : Float, y : Float, r : Float, g : Float, b : Float, a : Float, u : Float = 0., v : Float = 0. ) {
		var half = lineSize / 2.0;
		if( x - half < xMin ) xMin = x - half;
		if( y - half < yMin ) yMin = y - half;
		if( x + half > xMax ) xMax = x + half;
		if( y + half > yMax ) yMax = y + half;
		if( x < xMinSize ) xMinSize = x;
		if( y < yMinSize ) yMinSize = y;
		if( x > xMaxSize ) xMaxSize = x;
		if( y > yMaxSize ) yMaxSize = y;
		if( doFill )
			content.add(x, y, u, v, r, g, b, a);
		var gp = new GPoint();
		gp.load(x, y, lineR, lineG, lineB, lineA);
		tmpPoints.push(gp);
	}


    function flush() {
		if( tmpPoints.length == 0 )
			return;
		if( doFill ) {
			flushFill(pindex);
			pindex += tmpPoints.length;
			if( content.next() )
				pindex = 0;
		}
		if( lineSize > 0 ) {
			flushLine(pindex);
			if( content.next() )
				pindex = 0;
		}
		tmpPoints = [];
    }

	static var EARCUT = null;

	function flushFill( i0 ) {

		if( tmpPoints.length < 3 )
			return;

		var pts = tmpPoints;
		var p0 = pts[0];
		var p1 = pts[pts.length - 1];
		var last = null;
		// closed poly
		if( abs(p0.x - p1.x) < 1e-9 && abs(p0.y - p1.y) < 1e-9 )
			last = pts.pop();

		if( isConvex(pts) ) {
			for( i in 1...pts.length - 1 ) {
				content.addIndex(i0);
				content.addIndex(i0 + i);
				content.addIndex(i0 + i + 1);
			}
		} else {
			var ear = EARCUT;
			if( ear == null )
				EARCUT = ear = new Earcut();
			for( i in ear.triangulate(pts) )
				content.addIndex(i + i0);
		}

		if( last != null )
			pts.push(last);
	}

}

