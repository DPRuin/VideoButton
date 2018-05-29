//
//  ViewController.swift
//  VideoButton
//
//  Created by mac126 on 2018/5/29.
//  Copyright © 2018年 mac126. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var squishButton: SquishButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var count: Float!
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view, typically from a nib.
        setupSlider()
        
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchUpInside(sender:)), for: UIControlEvents.touchUpInside)
        
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchBegin(sender:)), for: UIControlEvents.touchDown)
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchEnd(sender:)), for: UIControlEvents.touchDragInside)
        squishButton.addTarget(self, action: #selector(self.squishButtonTouchEnd(sender:)), for: UIControlEvents.touchDragOutside)
        
    }
    
    func setupSlider() {
//        let inset: CGFloat = 10.0
//        let y = view.bounds.height - inset
//        let width = view.bounds.
//        let rect = CGRect(x: inset, y: y, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//        let slider = UISlider(frame: <#T##CGRect#>)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func squishButtonTouchUpInside(sender: UIButton) {
        print("squishButtonTouchUpInside")
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
    
    @objc func handleTimer(sender: Timer) {
        count = count + 0.1
        print("-count-\(count)")
    }
}

