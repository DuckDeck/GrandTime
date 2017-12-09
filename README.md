# GrandTime
【开发GrandTime的目的很简单，是用来代替NSDate,它提供了用户友好的，方便的简单的API，同时还有一个弱Timer，用来代替NSTimer】



【GrandTime是一个简单的，用户友好的同时也很强力的时间工具，大家都明白的，iOS自带的NSDate类很不好，非常难用，所以我开发了GrandTime来代替NSDate(并非所有功能),GrandTime由DateTime,TimeSpan 和 GrandTimer组成， GrandTimer是一个弱Timer,它可以自动回收内存当ViewController被pop出去时，下面我将在demo代码里战展示】

## 【关键特点】
+ 【非常友好和简单的API设计】
+ 【使用专门的类TimeSpan来表示时间间隔】
+ 【重载了操作符，可以使用操作符来极为简单地操作DateTime】
+ 【GrandTimer是一个weak 计时器。当ViewController被弹出时，他会自动停止调用并销毁】

## 【系统要求】
 【Xcode 7.3 and iOS 8.0 最新的Swift版本】

##【安装】
+  【使用Cocoapods安装， pod 'GrandTime'】
+ 【手动导入，只要把项目拖进你的文件就行】

## 【怎么使用】
【请参考以下代码】

```Swift
      print("----------------------------------下面是DateTime----------------------------------")

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
            
    
    let timeSpanOneMinute = TimeSpan.fromMinuts(1)   //声明一个一分钟的TimeSpan
    let dToOneMinuteBefore = a - timeSpanOneMinute      // 一分钟前
    print("一分钟前\(dToOneMinuteBefore)")
    let dToOneMinuteAfter = a + timeSpanOneMinute // 一分钟后
    print("一分钟后\(dToOneMinuteAfter)")
            
   //两个DateTime相减生成一个TimeSpan
    let span = c - a
            
    print("a和c相差一小时\(span)")
            
    print("a>c:\(a>c)")
    rint("a<c:\(a<c)")
            
    
            
            
            
    a.addYears(1)   //加一年
    print("add Years:\(a)")
    a.addMonth(1)   // 加 一个月
    print("add addMonth:\(a)")
    a.addDays(1)    // 加一天
    print("add addDays:\(a)")
    a.addHours(1)   // 加一个小时
    print("add addHours:\(a)")
    a.addMinutes(1) // 加一分钟
    print("add addMinutes:\(a)")
    a.addSeconds(1) // 加一秒
    print("add addSeconds:\(a)")
    
            
            
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
    print("再次获取i的各部分：year:\(i.year),   month:\(i.month),   day:\(i.day),   hour:\(i.hour),   minute:\(i.minute),   second:\(i.second),   minute:\(i.minute),   ticks:\(i.ticks),   ")
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
    print("LongStyle: \(i.format(.ShortStyle, timeFormat: .ShortStyle))")
    print("LongStyle: \(i.format(.MediumStyle, timeFormat: .MediumStyle))")
    print("LongStyle: \(i.format(.LongStyle, timeFormat: .LongStyle))")
    print("LongStyle: \(i.format(.FullStyle, timeFormat: .FullStyle))")
    i.local = NSLocale(localeIdentifier: "en_US")
    print("把地区设为US")
    print("LongStyle: \(i.format(.ShortStyle, timeFormat: .ShortStyle))")
    print("LongStyle: \(i.format(.MediumStyle, timeFormat: .MediumStyle))")
    print("LongStyle: \(i.format(.LongStyle, timeFormat: .LongStyle))")
    print("LongStyle: \(i.format(.FullStyle, timeFormat: .FullStyle))")
            
            
    //下面是timespan
    print("----------------------------------下面是TimeSpan----------------------------------")
    //先看看构造函数
    
    let o = TimeSpan()                                                                 //直接初始化
    print(o)    
    let p = TimeSpan(days: 1, hours: 0, minutes: 11, seconds: 31)   //使用天，小时，分钟，秒来初始化
    print(p)
    let q = TimeSpan(days: 20, hours: 11, minutes: 39, seconds: 21, milliseconds: 111)!   //使用天，小时，分钟，秒还有来初始化
    print(q)
    let r = TimeSpan(ticks: 9826127)   //使用tick来初始化
    print(r)
            
    //下面获取部分
    print("获取i的各部分：  day:\(q.days),   hour:\(q.hours),   minute:\(q.minutes),   second:\(q.seconds),   minute:\(q.milliseconds),  ticks:\(q.ticks),   ")
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
//如果pop出来，timer是可以自动回收内存的
```

##Contact 
Any issue or problem please contact me:3421902@qq.com, I will be happy fix it
【任何问题或者BUG请直接和我联系3421902@qq.com, 我会乐于帮你解决】
