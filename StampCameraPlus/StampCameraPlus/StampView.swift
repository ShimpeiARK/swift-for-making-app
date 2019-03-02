//
//  StampView.swift
//  StampCamera
//
//  Created by Yukinaga2 on 2017/12/10.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

enum StampScale {
    case small
    case medium
    case large
}

class StampView: UIImageView {
    
    var scale: StampScale = .medium
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubview(toFront: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
    }
}
