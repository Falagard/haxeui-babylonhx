package haxe.ui.backend;

import haxe.ui.backend.babylonhx.Graphics;
import com.babylonhx.ui.UIComponent;

class ComponentSurface extends UIComponent  {
     public function new() {
        super();
     }

     public var styleGraphics(default, default):Graphics = null;

     public var bgImageGraphics(default,default):Graphics = null;

}