//: Playground - noun: a place where people can play

import UIKit
protocol TimerSchedulable {
    var timeInterval: NSTimeInterval { get }
    var valid: Bool { get }
    func fire()
    func invalidate()
}

extension NSTimer: TimerSchedulable { }

typealias TimerCallback = (TimerSchedulable) -> (Void)
class Timer {
    private struct Properties {
        var fireDate: NSDate
        var interval: NSTimeInterval
        var userInfo: AnyObject?
        var repeats: Bool
    }
    
    private var _callback: TimerCallback
    private var _properties: Properties
    private lazy var _timer: NSTimer = { [unowned self] in
        NSTimer(fireDate: self._properties.fireDate, interval: self._properties.interval, target: self, selector: "timerTickCallback:", userInfo: self._properties.userInfo, repeats: self._properties.repeats)
        }()
    
    var fireDate: NSDate {
        set {
            _timer.fireDate = newValue
        }
        get {
            return _timer.fireDate
        }
    }
    
    var tolerance: NSTimeInterval {
        set {
            _timer.tolerance = newValue
        }
        get {
            return _timer.tolerance
        }
    }
    
    var userInfo: AnyObject? {
        return _timer.userInfo
    }
    
    init(fireDate: NSDate, timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: TimerCallback) {
        _properties = Properties(fireDate: fireDate, interval: timeInterval, userInfo: userInfo, repeats: repeats)
        _callback = callback
    }
}

extension Timer: TimerSchedulable {
    var timeInterval: NSTimeInterval {
        return _timer.timeInterval
    }
    
    var valid: Bool {
        return _timer.valid
    }
    
    func fire() {
        _timer.fire()
    }
    
    func invalidate() {
        _timer.invalidate()
    }
}

extension Timer {
    class func timerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: TimerCallback) -> Timer {
        let interval: NSTimeInterval = (timeInterval > 0) ? timeInterval : 0.1
        return Timer(fireDate: NSDate(), timeInterval: interval, userInfo: userInfo, repeats: repeats, callback: callback)
    }
    
    class func scheduledTimerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: TimerCallback) -> Timer {
        let interval: NSTimeInterval = (timeInterval > 0) ? timeInterval : 0.1
        let date = NSDate().dateByAddingTimeInterval(interval)
        let timer = Timer(fireDate: date, timeInterval: interval, userInfo: userInfo, repeats: repeats, callback: callback)
        timer.schedule(NSRunLoop.currentRunLoop(), mode: NSDefaultRunLoopMode)
        return timer
    }
    
    func schedule(onRunLoop: NSRunLoop) {
        schedule(onRunLoop, mode: NSDefaultRunLoopMode)
    }
    
    func schedule(onRunLoop: NSRunLoop, mode: String) {
        onRunLoop.addTimer(_timer, forMode: mode)
    }
    
    @objc private func timerTickCallback(sender: AnyObject) {
        _callback(self)
    }
}

// Timer

let timer = Timer.scheduledTimerWithTimeInterval(1, userInfo: nil, repeats: true) { timer in
    print("-> timer...")
}

dispatch_after(3, dispatch_get_main_queue()) { () -> Void in
    timer.invalidate()
}
