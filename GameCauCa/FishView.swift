//
//  FIsh.swift
//  GameCauCa
//
//  Created by Minh Tuan on 6/27/17.
//  Copyright © 2017 Minh Tuan. All rights reserved.
//

import UIKit
// vẽ cá và chuyển động của cá
class FishView: UIImageView {
    var status : Int?
    var speed : Int? // lưu lại tốc độ của cá
    var vy : Int?
    var widthFrame : Int? //lưu chiều dài của frame
    var heightFrame: Int?
    var widthFish : Int?
    var heightFish: Int?
    let MOVING : Int = 0
    let CAUGHT : Int = 1
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func generateFish(width:Int) {
        self.widthFrame = width
        self.vy = Int(arc4random_uniform(3)) - 1
        let y:Float = Float(arc4random_uniform(540)) + 80
        self.status = MOVING
        self.speed = (Int)(arc4random_uniform(5)) + 2
        if(Int(self.center.x) <= -Int(self.widthFish! / 2)){
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: "fish1")
            self.frame = CGRect(x: -CGFloat(self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!),height: CGFloat(self.heightFish!))
        }
        else
        {
            // quay đầu con cá
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: UIImage(named:"fish1")!.cgImage!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
            self.frame = CGRect(x: CGFloat(self.widthFrame!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            self.speed = -Int(self.speed!)
        }
    }
    func updateMove(){
        if (self.status == MOVING){
            // xét kiểu di chuyển của cá
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            // check vị trí của con cá trên chiều cao
            if (Int(self.center.y) < -Int(self.heightFish!) || Int(self.center.y) > self.heightFish! + 540)
            {
                self.vy = -self.vy!
            }
            // xét trường hợp các chạy ra 2 bên mép
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0 || (Int(self.center.x) < -self.widthFish! && self.speed! < 0)))
                {
                    generateFish(width: self.widthFrame!)
            }
        }
        else if (self.status == CAUGHT)
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            // sau khi cá bị kéo lên đỉnh sẽ tạo lại cá
            if (Int(self.frame.origin.y) <= -Int(self.widthFish!))
            {
                generateFish(width: self.widthFrame!)
            }
        }
    }
    // các mắc câu sẽ bị quay lên trên 
    func caught(){
        if (self.status == MOVING){
            self.status = CAUGHT
            if (self.speed! > 0)
            {
                self.transform = CGAffineTransform(rotationAngle: CGFloat( -M_PI_2))
            }
        }
        else{
            self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        }
    }

}
