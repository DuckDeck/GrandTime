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
        
        
        let d = DateTime.now
        print(d)
       let timeSpanOneMinute = TimeSpan.fromMinuts(1)
        let dToOneMinuteBefore = d - timeSpanOneMinute
        print(dToOneMinuteBefore)
        let dToOneMinuteAfter = d + timeSpanOneMinute
        print(dToOneMinuteAfter)
        d.addYears(1)
        print("add Years:\(d)")
        d.addMonth(1)
        print("add addMonth:\(d)")
        d.addDays(1)
        print("add addDays:\(d)")
        d.addHours(1)
        print("add addHours:\(d)")
        d.addMinutes(1)
        print("add addMinutes:\(d)")
        d.addSeconds(1)
        print("add addSeconds:\(d)")
        //正面看看构造函数
        let a = DateTime()
        print(a)
        let c = DateTime(date: NSDate(timeInterval: 3600, sinceDate: NSDate()))
        print(c)
         let e = DateTime(tick: 1000000)
        print(e)
        let f = DateTime(tickSinceNow: 60000)
        print(f)
        let g = DateTime(timestamp: 100000)
        print(g)
        let h = DateTime(year: 2008, month: 2, day: 29)
        print(h)
        let i = DateTime(year: 2016, month: 12, day: 12, hour: 11, minute: 44, second: 12, millisecond: 111)!
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
        
        
        //下面是timespan
        print("----------------------------------下面是TimeSpan----------------------------------")
         let o = TimeSpan()
        print(o)
        let p = TimeSpan(days: 1, hours: 0, minutes: 11, seconds: 31)
        print(p)
        let q = TimeSpan(days: 20, hours: 11, minutes: 39, seconds: 21, milliseconds: 111)
        print(q)
        let r = TimeSpan(ticks: 9826127)
        print(r)
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

