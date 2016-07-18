# GrandTime
GrandTime 's purpose is simple,  replace NSDate and provide a user-friend , convenience and simple API ,mean while. It contain a weak timer to replace NSTimer 

【开发GrandTime的目的很简单，是用来代替NSDate,它提供了用户友好的，方便的简单的API，同时还有一个弱Timer，用来代替NSTimer】

GrandTime is a simple ,user-friendly and powerful Datetime tool. as you know, the original iOS date API is awful,very difficult to use. So a develop this GrandTime to replace the NSDate API（not all feature）. GrandTimer consist of DateTime,TimeSpan and GrandTimer. GrandTImer is a weak timer. it can automaticallu recyle the memory when the ViewController pop out.I will show how to use it in the demo code

【GrandTime是一个简单的，用户友好的同时也很强力的时间工具，大家都明白的，iOS自带的NSDate类很不好，非常难用，所以我开发了GrandTime来代替NSDate(并非所有功能),GrandTime由DateTime,TimeSpan 和 GrandTimer组成， GrandTimer是一个弱Timer,它可以自动回收内存当ViewController被pop出去时，下面我将在demo代码里战展示】

## Key Features
+ Very user-friend and simple API design【非常友好和简单的API设计】
+ Use TimeSpan to describe time interval【使用专门的类TimeSpan来表示时间间隔】
+ override operator, you can use operator manipulate DateTime very simple【重载了操作符，可以使用操作符来极为简单地操作DateTime】
+ GramdTimer is a weak timer when the VIewController pop to the navigationController, it can deinit correctly【GrandTimer是一个weak 计时器。当ViewController被弹出时，他会自动停止调用并销毁】

## Requirements 【系统要求】
Xcode 7.3 and iOS 8.0 the last Swift version 【Xcode 7.3 and iOS 8.0 最新的Swift版本】

##Installation【安装】
+ Installation with CocoaPods：pod 'GrandTime' 【使用Cocoapods安装， pod 'GrandTime'】
+ Manual import, just need darg all the file to your project[手动导入，只要把项目拖进你的文件就行]

##How To Use It 【怎么使用】
Please see these code below【请参考以下代码】

```Swift
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

```

DateTime和TimeSpan的使用足够简单
下面是GrandTimer的用法

```Swift
    var timer:GrandTimer?  //在ViewController里面声明一个变量
    var seco2 = 0
    override func viewDidLoad() {
       //使用者要注意，这个timer本身是waak的，所以需要一个外部变量来强引用， 所以需要赋值给一个外部变量才行
      //如果要让timer正确地释放内存，那么要使用weakself
      timer =  GrandTimer.every(TimeSpan.fromSeconds(1)) {
            weakSelf!.seco2 = weakSelf!.seco2 + 1
            weakSelf!.lblTimer.text = "\(weakSelf!.seco2)"
        }

```

##Contact 
Any issue or problem please contact me:3421902@qq.com, I will be happy fix it
【任何问题或者BUG请直接和我联系3421902@qq.com, 我会乐于帮你解决】
