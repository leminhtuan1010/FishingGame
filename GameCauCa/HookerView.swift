//
//  Hooker.swift
//  GameCauCa
//
//  Created by Minh Tuan on 6/27/17.
//  Copyright © 2017 Minh Tuan. All rights reserved.
//

import UIKit

class HookerView: UIImageView {
    let PREPARE = 0 // bắt đầu kéo
    let DROPPING = 1 // đang kéo xuống
    let DRAWINGUP = 2// kéo lên
    let CAUGHTF = 3 // bắt được cá
    var status : Int? // lưu trạng thái của móc câu
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named:"hook")
        self.status = PREPARE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateMove()
    {
        if (self.status == DROPPING) // bắt đầu kéo xuống
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y + 10)
            // nếu lớn hơn thì kéo lên
            if (self.frame.origin.y + self.frame.height > 580)
            {
                self.status = DRAWINGUP
            }
        }
        else if (self.status == DRAWINGUP) // bắt đầu kéo lên
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 20)
            if (self.frame.origin.y + self.frame.size.height < 0) // lên đỉnh thì bắt đàua kéu được tiếp theo
            {
                self.status = PREPARE
            }
        }
        else if (self.status == CAUGHTF) // bắt được cá thì tốc độ chậm hơn
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if (self.frame.origin.y + self.frame.height < 0)
            {
                self.status = PREPARE
            }
        }
        
        
    }
    func dropDownAtX(_ x: Int) // click vào đâu thì hook bắt đầu chạy xuống ở đó
    {
        if (self.status == PREPARE)
        {
            self.center = CGPoint(x: CGFloat(x), y: self.center.y)
            self.status = DROPPING
        }
    }
    
    
    
}

