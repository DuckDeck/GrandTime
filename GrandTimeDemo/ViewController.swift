//
//  ViewController.swift
//  GrandTimeDemo
//
//  Created by Stan Hu on 2020/3/17.
//

import UIKit

class ViewController: UIViewController {
    let btnAddMonth = UIButton()
    let btnDeductMonth = UIButton()
    let lblMonth = UILabel()
    var time:DateTime!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        time = DateTime.parse("2017-12-12", format: "yyyy-MM-dd")!
        
        lblMonth.text = DateTime.now.format()
        lblMonth.frame = CGRect(x: 100, y: 300, width: 250, height: 40)
        view.addSubview(lblMonth)
        
        btnAddMonth.setTitle("加一个月", for: .normal)
        btnAddMonth.setTitleColor(UIColor.black, for: .normal)
        btnAddMonth.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        btnAddMonth.addTarget(self, action: #selector(addMonth), for: .touchUpInside)
        view.addSubview(btnAddMonth)
        
        btnDeductMonth.setTitle("减一个月", for: .normal)
        btnDeductMonth.setTitleColor(UIColor.black, for: .normal)
        btnDeductMonth.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        btnDeductMonth.addTarget(self, action: #selector(deductMonth), for: .touchUpInside)
        view.addSubview(btnDeductMonth)
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextPage))
    }
    
    @objc func addMonth() {
        time.selfAddMonth(1)
               print(time!)
               lblMonth.text = time.format()
    }

    @objc func deductMonth() {
        time.selfAddMonth(-1)
               print(time!)
               lblMonth.text = time.format()
    }
    
    @objc func nextPage() {
        navigationController?.pushViewController(TimerViewController(), animated: true)
      }

}

