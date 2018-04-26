//
//  UnLockBuilderView.swift
//  unLockDemo
//
//  Created by 国投 on 2018/4/26.
//  Copyright © 2018年 FlyKite. All rights reserved.
//

import Foundation
import UIKit

class UnLockBuilder:NSObject {


    /// 最小连接的点数
    var minconnectcount:Int?
    /// 点的大小
    var doubleSize:CGFloat?
    /// 线的宽度
    var connectlineWidth:CGFloat?
    /// 线的颜色
    var connectlineColor:UIColor?

    var unConnectImg:UIImage?

    var connectImg:UIImage?

    var size:CGSize?


    func builderInstance() -> UnLockGestureView {
        let instance = UnLockGestureView()
        if let _ = minconnectcount {
            instance.minconnectcount = minconnectcount!
        }
        if let _ = doubleSize {
            instance.doubleSize = doubleSize!
        }
        if let _ = connectlineWidth {
            instance.connectlineWidth = connectlineWidth!
        }
        if let _ = connectlineColor {
            instance.connectlineColor = connectlineColor!
        }
        if let _ = unConnectImg {
            instance.unConnectImg = unConnectImg!
        }
        if let _ = connectImg {
            instance.connectImg = connectImg!
        }
        if let _ = size {
            instance.size = size!
        }
        instance.updateView()
        return instance
    }


}















































