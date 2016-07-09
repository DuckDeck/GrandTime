//
//  GrandTimer.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/26/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class GrandTimer: NSObject {
    
    
    struct timerFlags {
       static  var  timerIsInvalid:UInt32 = 0
    }
    
    var timeSpan:TimeSpan?
     var target:AnyObject?
    var selector:Selector?
   public var userInfo:AnyObject?
    var repeats:Bool = false
    var privateSerialQueue:dispatch_queue_t?
    var timer:dispatch_source_t?
    
   private override init() {
        super.init()
    }
    
   public convenience init(timespan:TimeSpan,target:AnyObject,sel:Selector,userInfo:AnyObject?,repeats:Bool,dispatchQueue:dispatch_queue_t){
        self.init()
        self.timeSpan = timespan
        self.target = target
        self.selector = sel
        self.userInfo = userInfo
        self.repeats = repeats
        let privateQueueName = "grandTime\(self)"
        self.privateSerialQueue = dispatch_queue_create(privateQueueName.cStringUsingEncoding(NSUTF8StringEncoding)!, DISPATCH_QUEUE_SERIAL)
        dispatch_set_target_queue(self.privateSerialQueue, dispatchQueue)
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.privateSerialQueue)
    }
    
  public  static func scheduleTimerWithTimeSpan(timespan:TimeSpan,target:AnyObject,sel:Selector,userInfo:AnyObject?,repeats:Bool,dispatchQueue:dispatch_queue_t)->GrandTimer{
        let timer = GrandTimer(timespan: timespan, target: target, sel: sel, userInfo: userInfo, repeats: repeats, dispatchQueue: dispatchQueue)
        timer.schedule()
        return timer
    
    }
    
    
    
  public  func schedule() {
        resetTimerProperties()
        weak var weakSelf = self
        dispatch_source_set_event_handler(self.timer!) { 
            weakSelf?.timerFired()
        }
        dispatch_resume(self.timer!)
    }
    
    deinit{
        invalidate()
    }
    
  public  func fire() {
        timerFired()
    }
    
    
    
  public  func invalidate() {
        if OSAtomicTestAndSetBarrier(7, &timerFlags.timerIsInvalid) {
            if  let timer = self.timer{
                dispatch_async(self.privateSerialQueue!, {
                    dispatch_source_cancel(timer)
                })
            }
        }
    }
    
    func timerFired() {
        if OSAtomicAnd32OrigBarrier(1, &timerFlags.timerIsInvalid) > 0{
            return
        }
        self.target?.performSelector(self.selector!, withObject: self)
        if !self.repeats {
            self.invalidate()
        }
        
    }
    var _tolerance:TimeSpan = TimeSpan()
   public var tolerance:TimeSpan?{
        set{
            objc_sync_enter(self)
            if newValue != nil && _tolerance != newValue{
                _tolerance = newValue!
            }
            resetTimerProperties()
            objc_sync_exit(self)

        }
        get{
//            objc_sync_enter(self)
            return _tolerance
//            objc_sync_exit(self)
        }
    }
    
    func resetTimerProperties()  {
        let intervalInNanoseconds:Int64 = Int64(self.timeSpan!.milliseconds) * 1000000
        let toleranceInNanoseconds:UInt64 = UInt64(self.tolerance!.milliseconds) * 1000000
        dispatch_source_set_timer(self.timer!, dispatch_time(DISPATCH_TIME_NOW, intervalInNanoseconds), UInt64(intervalInNanoseconds), toleranceInNanoseconds)
    }
    
    
    
    override var description: String{
        return "timeSpan = \(timeSpan) target = \(target) selector = \(selector) userinfo = \(userInfo) repeats = \(repeats) timer= \(timer)"
    }
    
    
}
