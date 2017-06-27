//
//  GameManager.swift
//  GameCauCa
//
//  Created by Minh Tuan on 6/27/17.
//  Copyright © 2017 Minh Tuan. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    var fishView : NSMutableArray?
    var hookView :HookerView?
    override init() {
        self.fishView = NSMutableArray()
        self.hookView = HookerView(frame: CGRect(x: 0, y: -490,width: 20, height: 490))
    }
    func addFishToviewController(viewcontroller: UIViewController, width: Int){
        let fishView = FishView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        fishView.generateFish(width: width)
        self.fishView?.add(fishView)
        viewcontroller.view.addSubview(fishView)
    }
    func updateMove()
    {
        self.hookView?.updateMove()
        for fishView in self.fishView!
        {
            (fishView as AnyObject).updateMove()
            
            if (((fishView as AnyObject).frame).contains(CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + (fishView as AnyObject).frame.width/2)))
            {
                bite (fishView: fishView as! FishView)
            }
        }
    }
    func dropHookerAtX(_ x: Int)
    {
        self.hookView?.dropDownAtX(x)
    }

    func bite(fishView: FishView) // trạng thái cá cắn câu
    {
        // khi con cá bị bắt
        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP){
            fishView.caught()
            fishView.center = CGPoint(x: self.hookView!.center.x, y: self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
        }
    }
}
