//
//  TimeSpan.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/23/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

public class TimeSpan: NSObject {
    var _day = 0
    var _hour = 0
    var _minute = 0
    var _second = 0
    var _millisecond = 0
    var _ticks = 0
    override init() {
        super.init()
    }
    
    convenience init(ticks:Int) {
        self.init()
        _ticks = ticks
    }
    
    convenience init(hours:Int,minutes:Int,seconds:Int) {
        self.init()
        assert(hours > 0, "hours must > 0")
        assert(minutes > 0 && minutes < 60, "minus must > 0 and < 60")
        assert(seconds > 0 && seconds < 60, "seconds must > 0 and < 60")
        _hour = hours
        _minute = minutes
        _second = seconds
    }
    
    convenience init(days:Int,hours:Int,minutes:Int,seconds:Int) {
        assert(hours > 0 && hours < 24, "hours must > 0 and < 24")
        self.init(hours:hours,minutes: minutes,seconds: seconds)
        _day = days
    }
    
    convenience init(days:Int,hours:Int,minutes:Int,seconds:Int,milliseconds:Int) {
        assert(milliseconds > 0 && milliseconds < 999, "milliseconds must > 0 and < 999")
        self.init(days:days,hours:hours,minutes: minutes,seconds: seconds)
        _millisecond = milliseconds
    }
    
    public var days:Int{
        get{
            return _day
        }
        set{
            _day = newValue
        }
    }
    
    
    
}
