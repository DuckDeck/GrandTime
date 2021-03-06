//
//  TimerViewController.swift
//  GrandTimeDemo
//
//  Created by Stan Hu on 2020/3/17.
//

import UIKit

class TimerViewController: UIViewController {
    let lblTImerBlock = UILabel()
    let lblTimer = UILabel()
    var timer:GrandTimer?
    var timer2:GrandTimer?
    var seco = 0
    var seco2 = 0
    var isPause = false
    let btnPause = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        lblTimer.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        view.addSubview(lblTimer)
        lblTImerBlock.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        view.addSubview(lblTImerBlock)

        btnPause.setTitle("暂停", for: .normal)
        btnPause.setTitleColor(UIColor.black, for: .normal)
        btnPause.frame = CGRect(x: 100, y: 500, width: 100, height: 40)
        btnPause.addTarget(self, action: #selector(pauseTimer(_:)), for: .touchUpInside)
        view.addSubview(btnPause)

         //   let dispatch = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT)
         //   timer = GrandTimer.scheduleTimerWithTimeSpan(TimeSpan.fromSeconds(1), target: self, sel: #selector(TimerViewController.tick), userInfo: nil, repeats: true, dispatchQueue: dispatch)
         //   timer?.fire()
    //         GrandTimer.every(TimeSpan.fromSeconds(5)) {
    //            self.seco2 = self.seco2 + 1
    //            self.lblTimer.text = "\(self.seco2)"
    //        }
            
    //        timer = GrandTimer.scheduleTimerWithTimeSpan(TimeSpan.fromSeconds(1), block: {
    //                        self.seco2 = self.seco2 + 1
    //                        self.lblTimer.text = "\(self.seco2)"
    //
    //            }, repeats: true, dispatchQueue: dispatch)

            
               //Issue2: I must use a var to receive the GrandTimer static func which is to return a GrandTimer instance. I don't know why
            //IF this werid stuff can not fix . I will feel unhappy.
            // I know wahy this weill not work .because the when out of the code bound, and there is no strong refrence to this timer. so the system will recycle the
            //timer .So it need a var to receive the Timer
            weak var weakSelf = self
            //使用者要注意，这个timer本身是weak的，所以需要一个外部变量来强引用，
            //如果要让timer正确地释放内存，那么要使用weakself
           timer = GrandTimer.every(TimeSpan.fromSeconds(1)) {
                weakSelf!.seco2 = weakSelf!.seco2 + 1
                weakSelf!.lblTimer.text = "\(weakSelf!.seco2)"
            }
            lblTImerBlock.text = "3秒后变红"
            timer?.fire()
     
            timer2 = GrandTimer.after(TimeSpan.fromSeconds(3), block: {
                weakSelf?.lblTImerBlock.backgroundColor = UIColor.red
            })
            timer2?.fire()
                
    }
    

    
      func tick()  {
          seco = seco + 1
          DispatchQueue.main.async {
                  self.lblTimer.text = "\(self.seco)"
          }
      }
    
    @objc func pauseTimer(_ sender: UIButton) {
        isPause = !isPause
        if isPause{
            timer?.pause()
        }
        else{
            timer?.fire()
        }
    }

}
