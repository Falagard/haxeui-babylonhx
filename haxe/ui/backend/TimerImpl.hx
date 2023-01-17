package haxe.ui.backend;

class TimerImpl {
    private var _timer:Timer;

    public function new(delay:Int, callback:Void->Void) {
        _timer = new Timer(delay);
        _timer.run = function() {
            callback();
        }
    }

    public function stop() {
        _timer.stop();
    }
}

// package haxe.ui.backend;

// //import com.babylonhx.engine.Engine;

// class TimerImpl {
//     static private var __timers:Array<TimerImpl> = [];

//     static public function update() {
//         // var currentTime:Float = Engine.LastCreatedEngine.getDeltaTime(); // hxd.Timer.lastTimeStamp;
//         // var count:Int = __timers.length;
//         // for (i in 0...count) {
//         //     var timer:TimerImpl = __timers[i];
//         //     if (!timer._stopped && currentTime > timer._end) {
//         //         timer._end = currentTime + timer._delay;
//         //         timer.callback();
//         //     }
//         // }

//         // while(--count >= 0) {
//         //     var timer:TimerImpl = __timers[count];
//         //     if (timer._stopped) {
//         //         __timers.remove(timer);
//         //     }
//         // }
//     }

//     public var callback:Void->Void;
//     private var _end:Float;
//     private var _delay:Float;
//     private var _stopped:Bool;

//     public function new(delay:Int, callback:Void->Void) {
//         this.callback = callback;
//         _delay = delay / 1000;
//         //_end = hxd.Timer.lastTimeStamp + _delay;
//         //_end = Engine.LastCreatedEngine.getDeltaTime() + delay;
//         _end = 0;
//         __timers.push(this);
//     }

//     public function stop() {
//         _stopped = true;
//     }
// }