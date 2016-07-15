# GrandTime
GrandTime 's purpose is simple,  replace NSDate and provide a user-friend , convenience and simple API ,mean while. It contain a weak timer to replace NSTimer 【开发GrandTime的目的很简单，是用来代替NSDate,它提供了用户友好的，方便的简单的API，同时还有一个弱Timer，用来代替NSTimer】

GrandTime is a simple ,user-friendly and powerful Datetime tool. as you know, the original iOS date API is awful,very difficult to use. So a develop this GrandTime to replace the NSDate API（not all feature）. GrandTimer consist of DateTime,TimeSpan and GrandTimer. GrandTImer is a weak timer. it can automaticallu recyle the memory when the ViewController pop out.I will show how to use it in the demo code
【GrandTime是一个简单的，用户友好的同时也很强力的时间工具，大家都明白的，iOS自带的NSDate类很不好，非常难用，所以我开发了GrandTime来代替NSDate(并非所有功能),GrandTime由DateTime,TimeSpan 和 GrandTimer组成， GrandTimer是一个弱Timer,它可以自动回收内存当ViewController被pop出去时，下面我将在demo代码里战展示】

## Key Features
+ Very user-friend and simple API design【非常友好和简单的API设计】
+ Use TimeSpan to describe time interval【使用专门的类TimeSpan来表示时间间隔】
+ override operator, you can use operator manipulate DateTime very simple【重载了操作符，可以使用操作符来极为简单地操作DateTime】
+ GramdTimer is a weak timer when the VIewController pop to the navigationController, it can deinit correctly【GrandTimer是一个weak 计时器。当ViewController被弹出时，他会自动停止调用并销毁】

## Requirements 【系统要求】
Xcode 7.3 and iOS 8.0 the last Swift version 【Xcode 7.3 and iOS 8.0 最新的Swift法版本】

##Installation【安装】
+ Installation with CocoaPods：pod 'GrandTime' 【使用Cocoapods安装， pod 'GrandTime'】
+ Manual import, just need darg all the file to your project[手动导入，只要把项目拖进你的文件就行]
+ 
##How To Use It 【怎么使用】
Please see these code below【请参考以下代码】

