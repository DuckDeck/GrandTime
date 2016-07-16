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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        print("----------------------------------下面是DateTime----------------------------------")
        let d = DateTime.now //使用现在声明一个新的DateTime对象
        print(d)
       let timeSpanOneMinute = TimeSpan.fromMinuts(1)   //声明一个一分钟的TimeSpan
        let dToOneMinuteBefore = d - timeSpanOneMinute      // 一分钟前
        print(dToOneMinuteBefore)
        let dToOneMinuteAfter = d + timeSpanOneMinute // 一分钟后
        print(dToOneMinuteAfter)
        d.addYears(1)   //加一年
        print("add Years:\(d)")
        d.addMonth(1)   // 加 一个月
        print("add addMonth:\(d)")
        d.addDays(1)    // 加一天
        print("add addDays:\(d)")
        d.addHours(1)   // 加一个小时
        print("add addHours:\(d)")
        d.addMinutes(1) // 加一分钟
        print("add addMinutes:\(d)")
        d.addSeconds(1) // 加一秒
        print("add addSeconds:\(d)")
        //正面看看构造函数
        let a = DateTime() //直接初始化
        print(a)
        let c = DateTime(date: NSDate(timeInterval: 3600, sinceDate: NSDate())) //使用NSDate初始化
        print(c)
         let e = DateTime(tick: 1000000) //使用Tick初始化  从1970年开始
        print(e)
        let f = DateTime(tickSinceNow: 60000) //使用Tick初始化  从现在年开始
        print(f)
        let g = DateTime(timestamp: 100000)//使用Stamp初始化
        print(g)
        let h = DateTime(year: 2008, month: 2, day: 29) //使用年月日初始化
        print(h)
        let i = DateTime(year: 2016, month: 12, day: 12, hour: 11, minute: 44, second: 12, millisecond: 111)!//使用年月日时分秒毫秒初始化
        print(i)
        
        
        //下面获取部分
        print("获取i的各部分：year:\(i.year),   month:\(i.month),   day:\(i.day),   hour:\(i.hour),   minute:\(i.minute),   second:\(i.second),   minute:\(i.minute),   ticks:\(i.ticks),   ")
        
        //还可以直接设置各部分
        i.year = 2015
        i.month = 1
        i.day = 12
        i.hour = 12
        i.minute = 23
        i.second = 12
        i.millisecond = 555
        print(i)
        print(i.weekDay)
        print(i.quarter)
        print(i.weekOfYear)
        print(i.weekOfMonth)
        print(i.ticks)
        print(i.dayOfYear)
        
        
        print(i.dateString)  //获取日期部分
        print(i.timeString)     //获取时间部分
        //下面是timespan
        print("----------------------------------下面是TimeSpan----------------------------------")
         let o = TimeSpan()
        print(o)
        let p = TimeSpan(days: 1, hours: 0, minutes: 11, seconds: 31)
        print(p)
        let q = TimeSpan(days: 20, hours: 11, minutes: 39, seconds: 21, milliseconds: 111)!
        print(q)
        let r = TimeSpan(ticks: 9826127)
        print(r)
        
        //下面获取部分
        print("获取i的各部分：  day:\(q.days),   hour:\(q.hours),   minute:\(q.minutes),   second:\(q.seconds),   minute:\(q.milliseconds),   ticks:\(q.ticks),   ")
        //获取计算的总体部分
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
        print("加减")
        s = s.add(r)
        print(s)
        
        s = s.subtract(r)
        print(s)
         print("+ - 也一样")
         s = s + r
        print(s)
        s = s - r
        print(s)
        
        return true
        
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

