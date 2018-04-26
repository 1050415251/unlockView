//
//  UnLockGestureView.swift
//  unLockDemo
//
//  Created by 国投 on 2018/4/26.
//  Copyright © 2018年 FlyKite. All rights reserved.
//

import Foundation
import UIKit

class UnLockGestureView:UIView {

    ///最小连接的点数
    var minconnectcount:Int = 4
    var doubleSize:CGFloat = 50
    var connectlineWidth:CGFloat = 10
    var connectlineColor:UIColor = UIColor.red

    var unConnectImg:UIImage = UIImage.init(contentsOfFile: Bundle.main.path(forResource: "unselected@2x", ofType: "png")!)!

    var connectImg:UIImage? = UIImage.init(contentsOfFile: Bundle.main.path(forResource: "selected@2x", ofType: "png")!)!

    var size:CGSize = CGSize.init(width: 300, height: 300)

    private var selectedIndex:[Int] = []

    private var lineLayers: [CAShapeLayer] = []
    private let linesLayer = CAShapeLayer.init()

    ///连接完成
    var connectfinshcomplete:(()->Void)?

    // 连接区域
    var touchdoubledistance:CGFloat {
        get {
            return doubleSize * 0.5
        }
    }

    private var pointCenters:[CGPoint] = []
    private var doubles:[UIImageView] = []

    class func newinstance(buildercallback:((UnLockBuilder)->Void)?) -> UnLockGestureView {
        let builder = UnLockBuilder()
        buildercallback?(builder)
        return builder.builderInstance()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addView()
        self.clipsToBounds = true
    }

    private func addView() {
        linesLayer.strokeColor = connectlineColor.cgColor
        linesLayer.fillColor = UIColor.red.cgColor
        linesLayer.lineWidth = connectlineWidth
        self.layer.addSublayer(linesLayer)


        let distance:CGFloat = (size.width - doubleSize * 3)/2
        for index in 0..<9 {
            let imgV = UIImageView(frame: CGRect.init(x:CGFloat(index%3) * (doubleSize + distance), y:CGFloat(index/3) * (doubleSize + distance), width: doubleSize, height: doubleSize))

            imgV.image = unConnectImg
            self.addSubview(imgV)
            pointCenters.append(imgV.center)
            doubles.append(imgV)
        }

        updateView()
    }

     func updateView() {
        linesLayer.strokeColor = connectlineColor.cgColor
        linesLayer.fillColor = UIColor.clear.cgColor
        linesLayer.lineWidth = connectlineWidth
        pointCenters.removeAll()
        let distance:CGFloat = (size.width - doubleSize * 3)/2
        for index in 0..<9 {
            doubles[index].frame = CGRect.init(x:CGFloat(index%3) * (doubleSize + distance), y:CGFloat(index/3) * (doubleSize + distance), width: doubleSize, height: doubleSize)
            doubles[index].image = unConnectImg
            pointCenters.append(doubles[index].center)

        }
    }


}


extension UnLockGestureView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        let position = touch.location(in: self)
        let x = Int(position.x / 100)
        let y = Int(position.y / 100)
        if x < 3 && x >= 0 && y < 3 && y >= 0 {
            let nearIndex = y * 3 + x
            let distance = distanceBetween(position, pointCenters[nearIndex])
            if distance < touchdoubledistance && !selectedIndex.contains(nearIndex) {
                hitPoint(nearIndex)
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if selectedIndex.count == 0 {
            return
        }
        let touch = touches.first!
        let position = touch.location(in: self)
        let x = Int(position.x / (size.width / 3))
        let y = Int(position.y / (size.height / 3))
        if x < 3 && x >= 0 && y < 3 && y >= 0 {
            let nearIndex = y * 3 + x
            let distance = distanceBetween(position, pointCenters[nearIndex])
            if distance < touchdoubledistance && !selectedIndex.contains(nearIndex) {
                hitPoint(nearIndex)
            }
        }
        drawLines(position)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        drawEnd()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        drawEnd()
    }

    private func drawEnd() {
        if selectedIndex.count > 0  {
            connectfinshcomplete?()
        }
        selectedIndex.removeAll()
        linesLayer.path = nil
        for layer in lineLayers {
            layer.removeFromSuperlayer()
        }
        lineLayers.removeAll()
        for image in doubles {
            image.image = unConnectImg
        }
    }

    private func hitPoint(_ index: Int) {
        if selectedIndex.count > 0 {
            let point1 = pointCenters[selectedIndex.last!]
            let point2 = pointCenters[index]

            let path = UIBezierPath.init()
            path.move(to: point1)
            path.addLine(to: point2)

            let layer = CAShapeLayer.init()
            layer.path = path.cgPath
            layer.strokeColor = connectlineColor.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = connectlineWidth
            self.layer.insertSublayer(layer, at: 0)
            lineLayers.append(layer)
        }
        doubles[index].image = connectImg
        selectedIndex.append(index)
    }

    private func drawLines(_ lastPoint: CGPoint) {
        let path = UIBezierPath.init()
        path.move(to: pointCenters[selectedIndex.last!])
        path.addLine(to: lastPoint)
        linesLayer.path = path.cgPath
    }

    private func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        let width = point1.x - point2.x
        let height = point1.y - point2.y
        let distance = sqrt(width * width + height * height)
        return distance
    }
}












































