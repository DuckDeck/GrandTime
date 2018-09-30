//
//  AppDelegate.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/23/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        print("----------------------------------下面是DateTime----------------------------------")
        
        
        
        //正面看看构造函数
        let a = DateTime() //直接初始化
        print(a)
        let c = DateTime(date: Date(timeInterval: 3600, since: Date())) //使用NSDate初始化
        print(c)
        let g = DateTime(timestamp: 100000)//使用Stamp初始化
        print(g!)
        let h = DateTime(year: 2008, month: 2, day: 29) //使用年月日初始化
        print(h!)
        let i = DateTime(year: 2016, month: 12, day: 12, hour: 11, minute: 44, second: 12, millisecond: 111)!//使用年月日时分秒毫秒初始化
        print(i)
        

       let timeSpanOneMinute = TimeSpan.fromMinuts(1)   //声明一个一分钟的TimeSpan
        let dToOneMinuteBefore = a - timeSpanOneMinute      // 一分钟前
        print("一分钟前\(dToOneMinuteBefore)")
        let dToOneMinuteAfter = a + timeSpanOneMinute // 一分钟后
        print("一分钟后\(dToOneMinuteAfter)")
        
        //两个DateTime相减生成一个TimeSpan
        let span = c - a
        
        print("a和c相差一小时\(String(describing: span))")
        
        print("a>c:\(a>c)")
        print("a<c:\(a<c)")
        

        
        
        
        a.selfAddYears(1)   //加一年
        print("add Years:\(a)")
        print(a.hashValue)
        a.selfAddMonth(1)   // 加 一个月
        print("add addMonth:\(a)")
        print(a.hashValue)
        a.selfAddDays(1)    // 加一天
        print("add addDays:\(a)")
        print(a.hashValue)
        a.selfAddHours(1)   // 加一个小时
        print("add addHours:\(a)")
        print(a.hashValue)
        a.selfAddMinutes(1) // 加一分钟
        print("add addMinutes:\(a)")
        print(a.hashValue)
        a.selfAddSeconds(1) // 加一秒
        print("add addSeconds:\(a)")
        print(a.hashValue)
        
        var dict = [DateTime:String]()
        dict[a] = "123"
        print(dict)
        

        
        //下面获取部分
        print("获取i的各部分：year:\(i.year),   month:\(i.month),   day:\(i.day),   hour:\(i.hour),   minute:\(i.minute),   second:\(i.second),   minute:\(i.minute),     ")
        
        //还可以直接设置各部分
        i.year = 2015
        i.month = 1
        i.day = 12
        i.hour = 12
        i.minute = 23
        i.second = 12
        i.millisecond = 555
         print("再次获取i的各部分：year:\(i.year),   month:\(i.month),   day:\(i.day),   hour:\(i.hour),   minute:\(i.minute),   second:\(i.second),   minute:\(i.minute),   ")
        //获取季度和星期相关数据
        print("星期几:\(i.weekDay)")
        print("第几季度:\(i.quarter)")
        print("一年的第几周:\(i.weekOfYear)")
        print("一个月的第几周:\(i.weekOfMonth)")
        print("一年的第几天:\(i.dayOfYear)")
        
        
        print("获取日期部分\(i.dateString)")  //获取日期部分
        print("获取时间部分\(i.timeString)")     //获取时间部分
        
        print("默认格式\(i.format())")
        print("自定义格式\(i.format("yyyy年MM月dd日#EEEE"))")
        print("各种输出style的原生的一样")
        print("LongStyle: \(i.format(.short, timeFormat: .short))")
        print("LongStyle: \(i.format(.medium, timeFormat: .medium))")
        print("LongStyle: \(i.format(.long, timeFormat: .long))")
        print("LongStyle: \(i.format(.full, timeFormat: .full))")
        i.local = Locale(identifier: "en_US")
         print("把地区设为US")
        print("LongStyle: \(i.format(.short, timeFormat: .short))")
        print("LongStyle: \(i.format(.medium, timeFormat: .medium))")
        print("LongStyle: \(i.format(.long, timeFormat: .long))")
        print("LongStyle: \(i.format(.full, timeFormat: .full))")
        
        
        //下面是timespan
        print("----------------------------------下面是TimeSpan----------------------------------")
        //先看看构造函数
        
         let o = TimeSpan()                                                                 //直接初始化
        print(o)
        let p = TimeSpan(days: 1, hours: 0, minutes: 11, seconds: 31)   //使用天，小时，分钟，秒来初始化
        print(p!)
        let q = TimeSpan(days: 20, hours: 11, minutes: 39, seconds: 21, milliseconds: 111)!   //使用天，小时，分钟，秒还有来初始化
        print(q)
        let r = TimeSpan(ticks: 9826127)   //使用tick来初始化
        print(r)
        
        //下面获取部分
        print("获取i的各部分：  day:\(q.days),   hour:\(q.hours),   minute:\(q.minutes),   second:\(q.seconds),   minute:\(q.milliseconds),   ticks:\(q.ticks),   ")
        //获取计算的总体部分
        print("获取i的各部分：  totalDays:\(q.totalDays),   totalHours:\(q.totalHours),   totalMinutes:\(q.totalMinutes),   second:\(q.totalSeconds)")
        //单独设定属性
        q.days = 4
        q.hours = 22
        q.minutes = 12
        q.seconds = 32
        q.milliseconds = 343
        print("获取i的各部分：  day:\(q.days),   hour:\(q.hours),   minute:\(q.minutes),   second:\(q.seconds),   minute:\(q.milliseconds),   ticks:\(q.ticks),   ")
        print("获取i的各部分：  totalDays:\(q.totalDays),   totalHours:\(q.totalHours),   totalMinutes:\(q.totalMinutes),   second:\(q.totalSeconds)")

        //使用from 函数
        print("使用from函数")
        var s = TimeSpan.fromDays(1) //一天
        print(s)
        s = TimeSpan.fromHours(2.5) //2.5小时
        print(s)
        s = TimeSpan.fromMinuts(89.2)//89.2分钟
        print(s)
        s = TimeSpan.fromSeconds(134)//134秒
        print(s)
        s = TimeSpan.fromTicks(123123123)//123123123 tick
        print(s)
        
        print("下面看加减")
        s = s.add(r)  //可以用这个加
        print(s)
        
        s = s.subtract(r)  //可以用这个减
        print(s)
         print("运算符+ - 也一样")
         s = s + r
        print(s)
        s = s - r
        print(s)
        
        
        let timespan1 = TimeSpan.parse("5 11:11:11", format: .dayFormat)
        let timespan2 = TimeSpan.parse("45:11:11", format: .timeFormat)
        let timespan3 = TimeSpan.parse("11:11:11:003", format: .msecFormat)
        let timespan4 = TimeSpan.parse("12 22:59:11:003", format: .allFormat)
        print(timespan1 ?? "空")
        print(timespan2 ?? "空")
        print(timespan3 ?? "空")
        print(timespan4 ?? "空")
        print(timespan4?.format(format: "dd天HH时mm分ss秒SSS虚秒") ?? "空")
        
        
        let last = DateTime.now - TimeSpan.fromDays(36500)
        //目录最少只能表示1970年，这样不合理,其实也没什么不合理的
        print(last)
        
        
        
        
        
        return true
        
        
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

