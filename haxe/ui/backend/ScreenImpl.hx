package haxe.ui.backend;

import haxe.ui.core.Component;
import com.babylonhx.ui.UIComponent;

class ScreenImpl extends ScreenBase {
    public function new() {
    }

    private var _root:UIComponent = null;
    public var root(get, set):UIComponent;
    private function get_root():UIComponent {
        //if (_root != null) {
            return _root;
        //}
        
        //if (options == null) {
        //    return null;
        //}
        
        //return options.root;
    }
    private function set_root(value:UIComponent):UIComponent {
        _root = value;
        return value;
    }

    public override function addComponent(component:Component):Component {
        rootComponents.push(component);
        if (component.parent == null || component.parent == root) {
            if (_removedComponents.indexOf(component) != -1) {
                if (root == null) {
                    trace("WARNING: trying to add a component to a null root. Either set Screen.instance.root or specify one in Toolkit.init");
                    return component;
                }
                _removedComponents.remove(component);
                component.visible = true;
            } else {
                if (root == null) {
                    trace("WARNING: trying to add a component to a null root. Either set Screen.instance.root or specify one in Toolkit.init");
                    return component;
                }
                root.addChild(component);
            }
        }
        resizeComponent(component);
        return component;
    }

    private var _removedComponents:Array<Component> = []; // TODO: probably ill conceived
    public override function removeComponent(component:Component, dispose:Bool = true, invalidate:Bool = true):Component {
        rootComponents.remove(component);
        if (_removedComponents.indexOf(component) == -1) {
            if (root == null) {
                trace("WARNING: trying to remove a component to a null root. Either set Screen.instance.root or specify one in Toolkit.init");
                return component;
            }
            _removedComponents.push(component);
            component.visible = false;
            if (dispose == true && root != null) {
                root.removeChild(component);
            }
            
            //CL-Todo - see if this needs to be implemented, need a version of MouseHelper.currentMouseX and currentMouseY
            //if (@:privateAccess component.inBounds(MouseHelper.currentMouseX, MouseHelper.currentMouseY)) {
            //    setCursor(null);
            //}
        }
        return component;
    }
}