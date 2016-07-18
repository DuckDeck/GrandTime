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
    case Monday = 0,Tuesday,Wendesday,Thursday,Friday,Saturday,Sunday
}



enum DisplayDateTimeStyleLanguage {
    case cn,us
}

public let LeapYearMonth = [31,29,31,30,31,30,31,31,30,31,30,31]
public let NotLeapYearMonth  = [31,28,31,30,31,30,31,31,30,31,30,31]

//这个会有点难，要算的东西有点多
public func -(left:DateTime,right:DateTime) -> TimeSpan? {
    let ms = left.dateTime.timeIntervalSinceDate(right.dateTime)
    if ms < 0 {
        print("DateTime warning: left time must bigger then right time")
        return nil
    }
    return TimeSpan(ticks: Int(ms) * 1000)
}

public func +(left:DateTime,right:TimeSpan) -> DateTime {
    let ms = Int(left.dateTime.timeIntervalSince1970 * 1000) + right.ticks
    return DateTime(tick: ms)!
}

public func -(left:DateTime,right:TimeSpan) -> DateTime {
    var ms = Int(left.dateTime.timeIntervalSince1970 * 1000) - right.ticks
    if ms < 0 {
        ms = 0
    }
    return DateTime(tick: ms)!
    
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
    public static let minDateTime = DateTime(tick: 0)
    //这里最大值一直不明确，但是我已经试过了，iOS里面最大的NSDate是一个非常大有年份，我可以保证没有人可以用到的
    public static let maxDateTime = DateTime(date: NSDate(timeIntervalSince1970: NSTimeInterval(Int.max) / 100000))
    
    private static let dateFormatter = NSDateFormatter()
    
    private  static var  dateComponent = NSDateComponents()
    
    
    
   private var dateTime:NSDate{
        // issue1 when in the init func .the disSet perocess do not work. this indeed not word. but it affect
        didSet{
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
    }
    public  var timeZone = NSTimeZone.systemTimeZone()  //这个要不要自己封装？ 先用系统的吧
    public  var dateTImeKind = DateTimeKind.Unspecified
    private var internalDateComponent:NSDateComponents
    public  override init() {
        internalDateComponent = NSDateComponents()
        dateTime = NSDate()
        super.init()
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    
    
    public convenience init?(tick:Int) {
        self.init()
        if ticks < 0 {
            print("DateTime warning: tick can not less than 0")
            return nil
        }
        else if ticks >= Int.max / 100000{
            print("DateTime warning: tick can not bigger than Int.max / 100000")
            return nil
        }
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
    
    public   convenience init?(tickSinceNow:Int) {
        self.init()
        //这个是以秒为单体，DateTime都是100纳秒为单位
        if ticks >= Int.max / 100000{
            print("DateTime warning: tickSinceNow can not bigger than Int.max / 100000")
            return nil
        }
        let interval = Int(NSDate().timeIntervalSince1970)
        if tickSinceNow < -(interval * 1000) {
            print("DateTime warning: tickSinceNow can not less than now to 1970 ticks")
            return nil
        }
        dateTime = NSDate(timeIntervalSinceNow: Double(tickSinceNow) / 1000.0)
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    
    
    public convenience init?(timestamp:Int){
        self.init()
        if timestamp < 0 {
            print("DateTime warning: timestamp can not less than 0")
            return nil
        }
        else if timestamp > Int.max / 100000{
            print("DateTime warning: timestamp can not bigger than Int.max / 100000")
            return nil
        }
        dateTime = NSDate(timeIntervalSince1970: NSTimeInterval(timestamp))
        internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
    }
    public convenience init?(year:Int,month:Int,day:Int) {
        self.init()
        if year < 1970 {
            print("DateTime warning: year can not less than 1970")
            return nil
        }
        else if year > 1000000 {
            print("DateTime warning: year can not bigger than 1000000")
            return nil
        }
        else if month < 1 {
            print("DateTime warning: month can not less than 1")
            return nil
        }
        else if month > 12 {
            print("DateTime warning: month can not bigger than 12")
            return nil
        }
        else if day < 1 {
            print("DateTime warning: day can not less than 0")
            return nil
        }
        else{
            var maxDays = 30
            if DateTime.isLeapYeay(year){
                maxDays = LeapYearMonth[month-1]
            }
            else{
                maxDays = NotLeapYearMonth[month-1]
            }
            if day > maxDays {
                print("DateTime warning: day can not  bigger than \(maxDays)")
                return nil
            }
        }
        DateTime.dateComponent.year = year
        DateTime.dateComponent.month = month
        DateTime.dateComponent.day = day
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
        else{
            print("DateTime warning: time Component data have issue")
            return nil
        }
    }
    
    public convenience init?(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int) {
        self.init(year:year,month:month,day:day)
        if hour < 0 {
            print("DateTime warning: hour can not less than 0")
            return nil
        }
        else if hour > 23 {
            print("DateTime warning: hour can not bigger than 23")
            return nil
        }
        else if minute < 0 {
            print("DateTime warning: minute can not less than 0")
            return nil
        }
        else if minute > 59 {
            print("DateTime warning: minute can not bigger than 59")
            return nil
        }
        else if second < 0 {
            print("DateTime warning: second can not  less than 0")
            return nil
        }
        else if second > 59{
            print("DateTime warning: second can not  bigger than 59")
            return nil
        }
        DateTime.dateComponent.hour = hour
        DateTime.dateComponent.minute = minute
        DateTime.dateComponent.second = second
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
        else{
            print("DateTime warning: time Component data have issue")
            return nil
        }
    }
    
    public convenience init?(year:Int,month:Int,day:Int,hour:Int,minute:Int,second:Int,millisecond:Int) {
        self.init(year:year,month:month,day:day,hour: hour,minute: minute,second: second)
        if millisecond < 0 {
            print("DateTime warning: millisecond can not less than 0")
            return nil
        }
        else if millisecond > 999{
            print("DateTime warning: millisecond can not bigger than 999")
            return nil
        }
        DateTime.dateComponent.nanosecond = millisecond
        if let date = NSCalendar.currentCalendar().dateFromComponents(DateTime.dateComponent){
            dateTime = date
            internalDateComponent =  NSCalendar.currentCalendar().components([.Weekday,.WeekOfYear,.Year,.Month,.Day,.Hour,.Minute,.Second,.Nanosecond,.Quarter,.WeekOfMonth,.WeekOfYear], fromDate: dateTime)
        }
        else{
            print("DateTime warning: time Component data have issue")
            return nil
        }
    }
    
    public var local = NSLocale(localeIdentifier: "zh_CN")
    
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
                print("DateTime warning: year have issue")
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
                print("DateTime warning: month have issue")
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
                print("DateTime warning: day have issue")
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
                print("DateTime warning: hore have issue")
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
                print("DateTime warning: minute have issue")
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
                print("DateTime warning: second have issue")
            }
        }
    }
    
    public var millisecond:Int{
        get{
            return internalDateComponent.nanosecond
        }
        set{
            internalDateComponent.nanosecond = newValue * 1000000
            if let date = NSCalendar.currentCalendar().dateFromComponents(internalDateComponent){
                dateTime = date
            }
            else{
                print("DateTime warning: millisecond have issue")
            }
        }
    }
    
    public var date:NSDate{
        return dateTime.copy() as! NSDate
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
        return format()
    }
    
    public override var debugDescription: String{
        return description
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
        return year % 4 == 0 && year % 100 != 0
    }
    
    // 这里目前不能传负数，但是如果是Int，类型，是应该可以接受负数的
    //这个地方有争议。很大有问题，不建议使用
    public func addMonth(months:Int)  {
        var i = month
        var currentYear = year
        //可以将month转化成day
        var  days = 0
        if months > 0 {
            while i < months + month{
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
        
        if months < 0 {
                i = month - 1
                while i >= months + month{
                if DateTime.isLeapYeay(currentYear) {
                    days = days + LeapYearMonth[abs(i) % 12]
                }
                else{
                    days = days + NotLeapYearMonth[abs(i) % 12]
                }
                if abs(i) % 12 == 0 {
                    currentYear = currentYear - 1
                }
                i = i - 1
            }
            addDays(Double(-days))
        }
    }
    
    public func addYears(years:Int){
        if year + years > 1000000 {
            print("DateTime warning: years is too big")
            return
        }
        addMonth(years * 12) //这样应该要吧
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
        dateTime = dateTime.dateByAddingTimeInterval(milliSeconds / 1000)
    }
    
    
    
   public static func compare(left:DateTime,right:DateTime)->Int{
        let result = left.dateTime.compare(right.dateTime)
        if result == .OrderedAscending {
            return -1
        }
        else if result == .OrderedDescending{
            return 1
        }
        return 0
    }
    
  public  func compareTo(time:DateTime) -> Int {
        return DateTime.compare(self, right: time)
    }
    
 public   func daysInMonth(year:Int,month:Int) -> Int? {
         if month < 1 {
            print("DateTime warning: month can not less than 1")
            return nil
        }
        else if month > 12 {
            print("DateTime warning: month can not bigger than 12")
            return nil
        }
        if DateTime.isLeapYeay(year) {
            return LeapYearMonth[month]
        }
        else{
            return NotLeapYearMonth[month]
        }
    }
    
   public static func equals(left:DateTime,right:DateTime)->Bool{
        return DateTime.compare(left, right: right) == 0
    }
    
  public  func  equals(time:DateTime) -> Bool {
        return DateTime.equals(self, right: time)
    }
    
    //最好用一个单例子来实现NSDateFormatter，因为NSDateFormatter
    //很吃资源
  public  func format(format:String = "yyyy-MM-dd HH:mm:ss:SSS") -> String {
        DateTime.dateFormatter.dateFormat = format
        return DateTime.dateFormatter.stringFromDate(dateTime)
    }
    
    public func format(dateFormat:NSDateFormatterStyle,timeFormat:NSDateFormatterStyle)->String{
        DateTime.dateFormatter.locale = local
        DateTime.dateFormatter.dateStyle = dateFormat
        DateTime.dateFormatter.timeStyle = timeFormat
        return DateTime.dateFormatter.stringFromDate(dateTime)
    }
    

    
  public  var dateString:String{
        return format("yyyy-MM-dd")
    }
    
  public   var timeString:String{
        return format("HH:mm:ss")
    }
    
    
    //这里还需要各种转化为时间的Style，需要补上
    
    
   public static func parse(time:String) -> DateTime? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.dateFromString(time){
            return DateTime(date: date)
        }
        else{
            return nil
        }
    }
    
  public  static func parse(time:String,format:String) -> DateTime? {
        dateFormatter.dateFormat = format
        if let date = dateFormatter.dateFromString(time){
            return DateTime(date: date)
        }
        else{
            return nil
        }
    }
    
    public override func copy() -> AnyObject {
        return DateTime(date: dateTime)
    }
}
