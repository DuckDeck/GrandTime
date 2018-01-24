//
//  ViewController.swift
//  GrandTimeDemo
//
//  Created by HuStan on 6/23/16.
//  Copyright © 2016 StanHu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var time:DateTime!
    @IBOutlet weak var lblMonth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        time = DateTime.parse("2017-12-12", format: "yyyy-MM-dd")!
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addMonth(_ sender: UIButton) {
        time.selfAddMonth(1)
        print(time)
        lblMonth.text = time.format()
    }
    
    @IBAction func decreaseMonth(_ sender: UIButton) {
        time.selfAddMonth(-1)
        print(time)
        lblMonth.text = time.format()
    }
}

