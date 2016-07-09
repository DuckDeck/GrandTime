//
//  TimerViewController.swift
//  GrandTimeDemo
//
//  Created by HuStan on 7/8/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var lblTImerBlock: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    var timer:GrandTimer?
    var seco = 0
    var seco2 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let dispatch = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT)
        timer = GrandTimer.scheduleTimerWithTimeSpan(TimeSpan.fromSeconds(1), target: self, sel: #selector(TimerViewController.tick), userInfo: nil, repeats: true, dispatchQueue: dispatch)
        timer?.fire()
         GrandTimer.every(TimeSpan.fromSeconds(2)) { 
            self.seco2 = self.seco2 + 1
            self.lblTimer.text = "\(self.seco2)"
        }
        // Do any additional setup after loading the view.
    }
    
    func tick()  {
        seco = seco + 1
        dispatch_async(dispatch_get_main_queue()) { 
                self.lblTimer.text = "\(self.seco)"
        }
    
    }

    deinit{
        print("\(self.dynamicType)) the view deinit which means the timer release the viewcontrollre")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
