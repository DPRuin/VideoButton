//
//  ViewController.swift
//  VideoButton
//
//  Created by mac126 on 2018/5/29.
//  Copyright © 2018年 mac126. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController {

    @IBOutlet weak var squishButton: SquishButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var count: Float!
    var timer: Timer!
    let maxVideoTime: Float = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view, typically from a nib.
        progressView.progress = 0
        progressView.isHidden = true
        
        progressView.progressTintColor = UIColor.red
        
        setupButtonGesture2()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupButtonGesture2() {
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchUpInside(sender:)), for: UIControlEvents.touchUpInside)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(squishButtonLongPress(gesture:)))
        // 定义长按0.8时间触发
        longPress.minimumPressDuration = 0.8
        squishButton.addGestureRecognizer(longPress)
    }
    
    @objc func squishButtonTouchUpInside(sender: UIButton) {
        print("squishButtonTouchUpInside")
        // 拍照
        squishButton.type = ButtonType.camera
        
    }
    
    @objc func squishButtonLongPress(gesture: UILongPressGestureRecognizer) {

        if gesture.state == .began { // 开始录制视频
            print("longpressbegan")
            squishButton.type = ButtonType.video
            
            progressView.isHidden = false
            
            count = 0
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleTimer(sender:)), userInfo: nil, repeats: true)
            timer.fire()
            
        } else if gesture.state == .ended { // 结束录制视频
            print("longpressended")
            squishButton.type = ButtonType.camera
            
            timer.invalidate()
            print("-count-\(count)")
            progressView.isHidden = true
        }
        
    }
    
    @objc func handleTimer(sender: Timer) {
        count = count + 0.1
        if maxVideoTime > count { // 继续录制视频
            progressView.progress = count / maxVideoTime
            
        } else { // 停止录制视频
            print("到时间了")
            let gesture = squishButton.gestureRecognizers?.filter({ (gesture) -> Bool in
                return gesture is UILongPressGestureRecognizer
            }).first as! UILongPressGestureRecognizer
            // ????state只读属性，苹果文档UIGestureRecognizer的子类UILongPressGestureRecognizer的state为可写可读
            // ARBear中不报错，这个程序中报错？？？Cannot
            gesture.state = .ended

//            timer.invalidate()
//            print("-count-\(count)")
//            progressView.isHidden = true
        }
    }
    
    
    
    
    // MARK: - 从触发按钮到离开按钮的时间内（不固定）触发的事件
    func setupButtonGesture3() {
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchBegin(sender:)), for: UIControlEvents.touchDown)
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchEnd(sender:)), for: UIControlEvents.touchUpInside)
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchEnd(sender:)), for: UIControlEvents.touchUpOutside)
    }
    
    @objc func squishButtonTouchBegin(sender: UIButton) {
        print("squishButtonTouchBegin")
        count = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleTimer(sender:)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func squishButtonTouchEnd(sender: UIButton) {
        print("squishButtonTouchEnd")
        timer.invalidate()
        print("-count-\(count)")
    }
    

}

