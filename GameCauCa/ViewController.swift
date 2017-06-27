//
//  ViewController.swift
//  GameCauCa
//
//  Created by Minh Tuan on 6/27/17.
//  Copyright © 2017 Minh Tuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var gameManager : GameManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToviewController(viewcontroller: self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(ViewController.tapHandle(_:))))
        Timer.scheduledTimer(timeInterval: 0.025, target: self.gameManager!, selector: Selector("updateMove"), userInfo: nil, repeats: true)
        
    }
    func tapHandle(_ sender: UIGestureRecognizer)
    {
        let tapPoint = sender.location(in: self.view)
       self.gameManager?.dropHookerAtX(Int(tapPoint.x))
    }
    @IBAction func reset(_ sender: Any) {
        self.gameManager?.fishView?.removeAllObjects()
        for object in self.view.subviews
        {
            if (object .isKind(of: FishView.self))
            {
                object .removeFromSuperview()
            }
        }
        self.gameManager?.addFishToviewController(viewcontroller: self, width: Int(self.view.bounds.width))

    }
    @IBAction func add(_ sender: Any) {
        self.gameManager?.addFishToviewController(viewcontroller: self, width: Int(self.view.bounds.width))

    }



}

