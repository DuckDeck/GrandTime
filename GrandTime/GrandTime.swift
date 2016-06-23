//
//  GrandTime.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/23/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit
//这个类就完全参考C#的DateTime
public enum  DateTimeKind:Int{
    case Unspecified=0,Utc,Local
}

public enum DayOfWeek:Int{
    case Monday = 0,Tuesday,Wedensday,Thursday,Friday,Saturday,Sunday
}

let LeapYearMonth = [31,29,31,30,31,30,31,31,30,31,30,31]
let NotLeapYearMonth  = [31,28,31,30,31,30,31,31,30,31,30,31]

public class DateTime: NSObject {
    
    
    
    //最小是1970年1月1号上午8点整
    public static let minDateTime = NSDate(timeIntervalSince1970: 0)
    //直接使用Int.max是不行的，太大了，至少要除100000
   public static let maxDateTime = NSDate(timeIntervalSince1970: NSTimeInterval(Int.max) / 100000)
   private  static var  dateComponent = NSDateComponents()
    
  var dateTime = NSDate()
  public  var timeZone = NSTimeZone.systemTimeZone()  //这个要不要自己封装？ 先用系统的吧
  public  var dateTImeKind = DateTimeKind.Unspecified
    override init() {
        super.init()
    }
    
 
    
   public convenience init(tick:Int) {
        self.init()
        assert(tick >= 0 && tick <= Int.max / 100000, "wrong tick")
        //这个是以秒为单体，DateTime都是100纳秒为单位
        dateTime = NSDate(timeIntervalSince1970: Double(tick) / 1000.0)
    }
    //暂时不要这个
//  public  convenience init(tick:Int,kind:DateTimeKind) {
//        self.init()
//        assert(tick >= 0 && tick <= Int.max / 100000, "wrong tick")
//        //这个是以秒为单体，DateTime都是100纳秒为单位
//        dateTImeKind = kind
//        dateTime = NSDate(timeIntervalSince1970: Double(tick) / 1000.0)
//    }
    
    public convenience init(year:Int,month:Int,day:Int) {
        self.init()
        dateTime = NSDate(timeIntervalSince1970: 0)
        assert(year >= 1970 && year <= 1000000, "year must big than 1970 and must less than 1000000")
        assert(month >= 1 && year <= 12, "month must big than 0 and less than 12")
        assert(day >= 1 && day <= 31, "day must big than 0 and less than 31")
        //这里还要特别计算，稍后处理,后面已经处理了
        DateTime.dateComponent.year = year
        DateTime.dateComponent.month = month
        DateTime.dateComponent.day = day
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
        }
        else{
            assert(true, "invalid day")
        }
    }
    
    public convenience init(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) {
        self.init(year:year,month:minute,day:day)
        assert(hour >= 0 && hour <= 23, "year must big than 1970 and must less than 1000000")
        assert(minute >= 0 && minute <= 59, "month must big than 0 and less than 12")
        assert(second >= 0 && second <= 59, "day must big than 0 and less than 31")
        DateTime.dateComponent.hour = hour
        DateTime.dateComponent.minute = minute
        DateTime.dateComponent.second = second
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
        }
        else{
            assert(true, "wrong parameters")
        }
    }
    
    public convenience init(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int,millisecond:Int) {
        self.init(year:year,month:minute,day:day,hour: hour,minute: minute,second: second)
        assert(millisecond >= 0 && millisecond <= 999, "millisecond must big than 0 and must less than 999")
        DateTime.dateComponent.nanosecond = millisecond
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
        }
        else{
            assert(true, "wrong parameters")
        }
    }
    
   public static var  now:DateTime{
        return DateTime()
    }
    
    public var dayOfWeek:DayOfWeek{
        get{
           let cal = NSCalendar.currentCalendar()
            let cmp = cal.component([.Weekday], fromDate: dateTime)
            return DayOfWeek(rawValue: cmp)!
        }
    }
    
    
    private var internalDateComponent:NSDateComponents{
        return NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    public var year:Int{
        get{
            return internalDateComponent.year
        }
        set{
            internalDateComponent.year = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }
    }
    
    public var month:Int{
        get{
            return internalDateComponent.month
        }
        set{
            internalDateComponent.month = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }    }
    
    
    public var day:Int{
        get{
            return internalDateComponent.day
        }
        set{
            internalDateComponent.day = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }
    }
    
    public var hour:Int{
        get{
            return internalDateComponent.hour
        }
        set{
            internalDateComponent.hour = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }    }
    
    public var minute:Int{
        get{
            return internalDateComponent.minute
        }
        set{
            internalDateComponent.minute = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }    }
    
    public var second:Int{
        get{
            return internalDateComponent.second
        }
        set{
            internalDateComponent.second = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }
    }
    
    public var millisecond:Int{
        get{
            return internalDateComponent.nanosecond
        }
        set{
            internalDateComponent.nanosecond = newValue
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                assert(true, "wrong parameters")
            }
        }
    }
    
    public var weekDay:DayOfWeek{
        return DayOfWeek(rawValue: internalDateComponent.weekday)!
    }
    
    public var quarter:Int{
        return  internalDateComponent.quarter

    }
    
    public var weekOfMonth:Int{
        return internalDateComponent.weekOfMonth
    }
    
    public var weekOfYear:Int{
        return internalDateComponent.weekOfYear
    }

    public var isLeapYear:Bool{
        return self.year / 4 == 0 && self.year / 100 != 0
    }
    
    public var ticks:Int{
         return Int(dateTime.timeIntervalSince1970 * Double(1000))
    }
   
    public var dayOfYear:Int{
        get{
            let month = self.month
            let day = self.day
            var days = 0
            if isLeapYear {
                var i = 0
                while i < month {
                    days += LeapYearMonth[i]
                    i = i + 1
                }
                return days + day
            }
            else{
                var i = 0
                while i < month {
                    days += NotLeapYearMonth[i]
                    i = i + 1
                }
                return days + day
            }
        }
    }
    
    
}
