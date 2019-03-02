//
//  StampBaseView.swift
//  StampCamera
//
//  Created by Yukinaga2 on 2017/12/10.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class StampBaseView: UIView {
    
    var originalImage: UIImage?
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    func setBackgroundImage(image: UIImage){
        backgroundImageView.image = image
        originalImage = image
    }
    
    func addStamp(stampImage: UIImage){
        let size = 100
        let stampView = StampView()
        stampView.image = stampImage
        stampView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        stampView.center = self.center
        stampView.isUserInteractionEnabled = true
        stampView.scale = .medium
        self.addSubview(stampView)
        
        UIView.animate(withDuration: 1.0, animations: {
            stampView.transform = CGAffineTransform(translationX: 0, y: -50)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                stampView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func changeStampSize(){
        if let topStamp = self.subviews.last as? StampView {
            switch topStamp.scale {
            case .small:
                topStamp.scale = .medium
                topStamp.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            case .medium:
                topStamp.scale = .large
                topStamp.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            case .large:
                topStamp.scale = .small
                topStamp.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
        }
    }
    
    func deleteStamp(){
        if let topStamp = self.subviews.last as? StampView {
            topStamp.removeFromSuperview()
        }
    }

    func saveImageWithStamps(){
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    }
}
