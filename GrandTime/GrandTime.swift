//
//  GrandTime.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/23/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import Foundation
//这个类就完全参考C#的DateTime
//基本功能先这样
public enum  DateTimeKind:Int{
    case Unspecified=0,Utc,Local
}

public enum DayOfWeek:Int{
    case Monday = 0,Tuesday,Wedensday,Thursday,Friday,Saturday,Sunday
}



let LeapYearMonth = [31,29,31,30,31,30,31,31,30,31,30,31]
let NotLeapYearMonth  = [31,28,31,30,31,30,31,31,30,31,30,31]

//这个会有点难，要算的东西有点多
func -(left:DateTime,right:DateTime) -> TimeSpan {
    let ms = left.dateTime.timeIntervalSinceDate(right.dateTime)
    assert(ms > 0,"left time must > right time")
    return TimeSpan(ticks: Int(ms) * 1000)
}

func +(left:DateTime,right:TimeSpan) -> DateTime {
    let ms = Int(left.dateTime.timeIntervalSince1970 * 1000) + right.ticks
    return DateTime(tick: ms)
}

func -(left:DateTime,right:TimeSpan) -> DateTime {
    let ms = Int(left.dateTime.timeIntervalSince1970 * 1000) - right.ticks
    assert(ms > 0, "the result date must > 0")
    return DateTime(tick: ms)
    
}

public func >(lhs: DateTime, rhs: DateTime) -> Bool {
    let ms = lhs.dateTime.timeIntervalSinceDate(rhs.dateTime)
    return ms > 0
}

public func >=(lhs: DateTime, rhs: DateTime) -> Bool {
    let ms = lhs.dateTime.timeIntervalSinceDate(rhs.dateTime)
    return ms >= 0
}

public func <(lhs: DateTime, rhs: DateTime) -> Bool {
    let ms = lhs.dateTime.timeIntervalSinceDate(rhs.dateTime)
    return ms < 0
}


public func <=(lhs: DateTime, rhs: DateTime) -> Bool {
    let ms = lhs.dateTime.timeIntervalSinceDate(rhs.dateTime)
    return ms <= 0
}


public class DateTime: NSObject,Comparable {
    
    
    
    //最小是1970年1月1号上午8点整
    public static let minDateTime = NSDate(timeIntervalSince1970: 0)
    //直接使用Int.max是不行的，太大了，至少要除100000
    public static let maxDateTime = NSDate(timeIntervalSince1970: NSTimeInterval(Int.max) / 100000)
    private  static var  dateComponent = NSDateComponents()
    
    var dateTime:NSDate{
        // issue1 when in the init func .the disSet perocess do not work.
        // need seek a way to fix it.
        didSet{
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
    }
    public  var timeZone = NSTimeZone.systemTimeZone()  //这个要不要自己封装？ 先用系统的吧
    public  var dateTImeKind = DateTimeKind.Unspecified
    private var internalDateComponent:NSDateComponents
    override init() {
        internalDateComponent = NSDateComponents()
        dateTime = NSDate()
        super.init()
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    
    
    public convenience init(tick:Int) {
        self.init()
        assert(tick >= 0 && tick <= Int.max / 100000, "wrong tick")
        //这个是以秒为单体，DateTime都是100纳秒为单位
        dateTime = NSDate(timeIntervalSince1970: Double(tick) / 1000.0)
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        
    }
    //暂时不要这个
    //  public  convenience init(tick:Int,kind:DateTimeKind) {
    //        self.init()
    //        assert(tick >= 0 && tick <= Int.max / 100000, "wrong tick")
    //        //这个是以秒为单体，DateTime都是100纳秒为单位
    //        dateTImeKind = kind
    //        dateTime = NSDate(timeIntervalSince1970: Double(tick) / 1000.0)
    //    }
    
    public convenience init(date:NSDate) {
        self.init()
        dateTime = date
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    public   convenience init(tickSinceNow:Int) {
        self.init()
        assert(tickSinceNow >= 0 && tickSinceNow <= Int.max / 100000, "wrong tick")
        //这个是以秒为单体，DateTime都是100纳秒为单位
        dateTime = NSDate(timeIntervalSinceNow: Double(tickSinceNow) / 1000.0)
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    
    public convenience init(timestamp:Int){
        self.init()
        assert(timestamp >= 0 && timestamp <= Int.max / 100000, "wrong timestamp")
        dateTime = NSDate(timeIntervalSince1970: NSTimeInterval(timestamp))
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    public convenience init(year:Int,month:Int,day:Int) {
        self.init()
        dateTime = NSDate(timeIntervalSince1970: 0)
        assert(year >= 1970 && year <= 1000000, "year must big than 1970 and must less than 1000000")
        assert(month >= 1 && month <= 12, "month must big than 0 and less than 12")
        assert(day >= 1 && day <= 31, "day must big than 0 and less than 31")
        //这里还要特别计算，稍后处理,后面已经处理了
        DateTime.dateComponent.year = year
        DateTime.dateComponent.month = month
        DateTime.dateComponent.day = day
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
        else{
            assert(true, "invalid day")
        }
    }
    
    public convenience init(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) {
        self.init(year:year,month:month,day:day)
        assert(hour >= 0 && hour <= 23, "year must big than 1970 and must less than 1000000")
        assert(minute >= 0 && minute <= 59, "month must big than 0 and less than 12")
        assert(second >= 0 && second <= 59, "day must big than 0 and less than 31")
        DateTime.dateComponent.hour = hour
        DateTime.dateComponent.minute = minute
        DateTime.dateComponent.second = second
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
        else{
            assert(true, "wrong parameters")
        }
    }
    
    public convenience init(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int,millisecond:Int) {
        self.init(year:year,month:month,day:day,hour: hour,minute: minute,second: second)
        assert(millisecond >= 0 && millisecond <= 999, "millisecond must big than 0 and must less than 999")
        DateTime.dateComponent.nanosecond = millisecond
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
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
        }
    }
    
    
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
        }
    }
    
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
        }
    }
    
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
    
    public var ticks:Int{
        return Int(dateTime.timeIntervalSince1970 * Double(1000))
    }
    
    //以后再做
    //    public var utcDateTime:Date{
    //        return NSTimeZone
    //    }
    
    
    public override var description: String{
        return self.format()
    }
    
    public override var debugDescription: String{
        return self.description
    }
    
    public var dayOfYear:Int{
        get{
            let month = self.month
            let day = self.day
            var days = 0
            if DateTime.isLeapYeay(self.year) {
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
    
    public static func isLeapYeay(year:Int)->Bool{
        return year / 4 == 0 && year / 100 != 0
    }
    
    public func addDays(days:Double)  {
        addMilliSeconds(days * Double(TickPerDay))
    }
    
    public func addHours(hours:Double)  {
         addMilliSeconds(hours * Double(TickPerHour))
    }
    
    public func addMinutes(minutes:Double) {
        addMilliSeconds(minutes * Double(TickPerMinute))
    }
    
    public func addSeconds(seconds:Double)  {
        addMilliSeconds(seconds * Double(TickPerSecond))
    }
    
    public func addMilliSeconds(milliSeconds:Double){
        assert(milliSeconds > 0,"the value must > 0")
        self.dateTime = self.dateTime.dateByAddingTimeInterval(milliSeconds / 1000)
    }
    
    // 这个逻辑有没有问题呢？好像没有，要测试 事实是有问题的
    public func addMonth(months:Int)  {
        var i = self.month
        var currentYear = self.year
        //可以将month转化成day
        var  days = 0
        while i < months + self.month{
            if DateTime.isLeapYeay(currentYear) {
                days = days + LeapYearMonth[i % 12]
            }
            else{
                days = days + NotLeapYearMonth[i % 12]
            }
            if i % 12 == 0 {
                currentYear = currentYear + 1
            }
            i = i + 1
        }
        addDays(Double(days))
    }
    
    public func addYears(years:Int){
         addMonth(years * 12) //这样应该要吧
    }
    
    static func compare(left:DateTime,right:DateTime)->Int{
        let result = left.dateTime.compare(right.dateTime)
        if result == .OrderedAscending {
            return -1
        }
        else if result == .OrderedDescending{
            return 1
        }
        return 0
    }
    
    func compareTo(time:DateTime) -> Int {
        return DateTime.compare(self, right: time)
    }
    
    func daysInMontu(year:Int,month:Int) -> Int {
        assert(month > 0 && month < 13,"month must > 0 and less than 13")
        if DateTime.isLeapYeay(year) {
            return LeapYearMonth[month]
        }
        else{
            return NotLeapYearMonth[month]
        }
    }
    
    static func equals(left:DateTime,right:DateTime)->Bool{
        return DateTime.compare(left, right: right) == 0
    }
    
    func  equals(time:DateTime) -> Bool {
        return DateTime.equals(self, right: time)
    }
    
    func format(format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self.dateTime)
    }
    
    static func parse(time:String) -> DateTime? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.dateFromString(time){
            return DateTime(date: date)
        }
        else{
            return nil
        }
    }
    
    static func parse(time:String,format:String) -> DateTime? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.dateFromString(time){
            return DateTime(date: date)
        }
        else{
            return nil
        }
    }
    
    public override func copy() -> AnyObject {
        return DateTime(date: self.dateTime)
    }
}
