//
//  ViewController.swift
//  unLockDemo
//
//  Created by 国投 on 2018/4/26.
//  Copyright © 2018年 FlyKite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view, typically from a nib.
        let view = UnLockGestureView.newinstance { (builder) in
            builder.connectlineWidth = 5
            builder.connectlineColor = UIColor.green
            builder.doubleSize = 20
            builder.size = CGSize.init(width: 100, height: 100)
        }
        view.frame = CGRect.init(x: 80, y: 90, width: 100, height: 100)
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

