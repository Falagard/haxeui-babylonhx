package haxe.ui.backend;

import haxe.ui.core.Component;
import haxe.ui.core.TextDisplay;
import haxe.ui.core.Screen;
import haxe.ui.events.UIEvent;
import haxe.ui.styles.Style;
import haxe.ui.backend.babylonhx.StyleHelper;
import com.babylonhx.engine.Engine;
import haxe.ui.validation.InvalidationFlags;

class ComponentImpl extends ComponentBase {
    public function new() {
        super();
        recursiveReady();
    }
    
    private function recursiveReady() {
        var component:Component = cast(this, Component);
        component.ready();
        for (child in component.childComponents) {
            child.recursiveReady();
        }
    }
    
    private override function handlePosition(left:Null<Float>, top:Null<Float>, style:Style) {
        if (left == null && top == null) {
            return;
        }

        left = Std.int(left);
        top = Std.int(top);
        
        //if (_mask == null) { //todo - implement mask
            if (this.x != left) {
                this.x = left * Toolkit.scaleX;
            } 
            if (this.y != top) {
                this.y = top * Toolkit.scaleY;
            } 
        //} else {
        //    if (_mask.x != left) _mask.x = left * Toolkit.scaleX;
        //    if (_mask.y != top)  _mask.y = top * Toolkit.scaleY;
        //}
        
        trace('${pad(this.id)}: move -> ${left}x${top}');
    }
    
    private override function handleSize(width:Null<Float>, height:Null<Float>, style:Style) {
        if (width == null || height == null || width < 0 || height < 0) {
            return;
        }

        width *= Toolkit.scaleX;
        height *= Toolkit.scaleY;
        
        //if (this.styleable) {
            StyleHelper.apply(this, style, width, height);
        //}
        
        trace('${pad(this.id)}: size -> ${width}x${height}');
    }
    
    //***********************************************************************************************************
    // Display tree
    //***********************************************************************************************************
    
    private override function handleSetComponentIndex(child:Component, index:Int) {
        addChildAt(child, index);
        trace('${pad(this.id)}: set component index -> ${child.id}, ${index}');
    }

    private override function handleAddComponent(child:Component):Component {
        addChild(child);
        trace('${pad(this.id)}: add component -> ${child.id}');
        return child;
    }

    private override function handleAddComponentAt(child:Component, index:Int):Component {
        addChildAt(child, index);
        trace('${pad(this.id)}: add component at index -> ${child.id}, ${index}');
        return child;
    }

    private override function handleRemoveComponent(child:Component, dispose:Bool = true):Component {
        removeChild(child);
        
        if (dispose == true) {
            child.dispose();
        }

        trace('${pad(this.id)}: remove component -> ${child.id}');
        return child;
    }

    private override function handleRemoveComponentAt(index:Int, dispose:Bool = true):Component {

        var child = _children[index];
        if (child != null) {
            removeChild(child);

            if (dispose == true) {
                child.dispose();
            }
        }

        trace('${pad(this.id)}: remove component at index -> ${index}');
        return null;
    }

    private var _deallocate:Bool = false;
    private var deallocate(null, set):Bool;
    private function set_deallocate(value:Bool) {
        _deallocate = value;
        for (c in this.childComponents) {
            c.deallocate = value;
        }
        return value;
    }
    private var _disposed:Bool = false;
    private function dispose() {
        if (_disposed == true) {
            return;
        }
        deallocate = true;
        removeChildren();
        //_mask = null; //CL todo - implement mask
        remove();
    }

    
    //***********************************************************************************************************
    // Style
    //***********************************************************************************************************
    private override function applyStyle(style:Style) {
        trace('${pad(this.id)}: apply style ->');
        if (style.backgroundColor != null) {
            if (style.backgroundColorEnd != null) {
                trace('${pad("")}:     background color: 0x' + StringTools.hex(style.backgroundColor, 6) + ', ' + StringTools.hex(style.backgroundColorEnd, 6));
            } else {
                trace('${pad("")}:     background color: 0x' + StringTools.hex(style.backgroundColor, 6));
            }
        }
        if (style.borderLeftSize != null && style.borderLeftColor != null) {
            trace('${pad("")}:     border left: ' + style.borderLeftSize + 'px, 0x' + StringTools.hex(style.borderLeftColor, 6));
        }
        if (style.borderTopSize != null && style.borderTopColor != null) {
            trace('${pad("")}:     border top: ' + style.borderTopSize + 'px, 0x' + StringTools.hex(style.borderTopColor, 6));
        }
        if (style.borderBottomSize != null && style.borderBottomColor != null) {
            trace('${pad("")}:     border bottom: ' + style.borderBottomSize + 'px, 0x' + StringTools.hex(style.borderBottomColor, 6));
        }
        if (style.borderRightSize != null && style.borderRightColor != null) {
            trace('${pad("")}:     border right: ' + style.borderRightSize + 'px, 0x' + StringTools.hex(style.borderRightColor, 6));
        }
    }
    
    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private override function mapEvent(type:String, listener:UIEvent->Void) {
        trace('${pad(this.id)}: map event -> ${type}');
    }
    
    private override function unmapEvent(type:String, listener:UIEvent->Void) {
        trace('${pad(this.id)}: unmap event -> ${type}');
    }
    
    //***********************************************************************************************************
    // Text related
    //***********************************************************************************************************
    public override function createTextDisplay(text:String = null):TextDisplay {
        if (_textDisplay == null) {
            trace('${pad(this.id)}: create text diplay');
        }
        return super.createTextDisplay(text);
    }
    
    //***********************************************************************************************************
    // Util
    //***********************************************************************************************************
    public static inline function pad(s:String, len:Int = 20):String {
        return StringTools.rpad(s, " ", len);
    }

    private  override function onAdd() {
        super.onAdd();
        if (this.parentComponent == null && Screen.instance.rootComponents.indexOf(cast this) == -1) {
            Screen.instance.addComponent(cast this);
        }
        cast(this, Component).ready();
    }
    
    private override function onRemove() {
        if (_deallocate == true) {
            _disposed = true;
            super.onRemove();
        }
        if (this.parentComponent == null && Screen.instance.rootComponents.indexOf(cast this) != -1) {
            Screen.instance.removeComponent(cast this, _deallocate);
        }
    }

    @:access(haxe.ui.core.Component)
    private function inBounds(x:Float, y:Float):Bool {
        //just return true for now
        return true;
    }
    
    public override function sync(engine: Engine) {
        var changed = posChanged;
        // if .x/.y property is access directly, we still want to honour it, so we will set haxeui's
        // .left/.top to keep them on sync, but only if the components position isnt already invalid
        // (which would mean this has come from a haxeui validation cycle)
        if (changed == true && isComponentInvalid(InvalidationFlags.POSITION) == false /* && _mask == null*/ ) { //CL todo - mask
            if (this.x != this.left) {
                this.left = this.x;
            }
            if (this.y != this.top) {
                this.top = this.y;
            }
        }
        super.sync(engine);
        //clearCaches(); CL todo - screenX/Y caching
    }

}