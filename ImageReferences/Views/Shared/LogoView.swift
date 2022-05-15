//
//  LogoView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class LogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLogo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogo(){
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2,
                                                         y: bounds.height / 2),
                                      radius: CGFloat(50),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor(red: 0.99, green: 0.65, blue: 0.29, alpha: 1.00).cgColor
        layer.addSublayer(shapeLayer)
        
        let imageName = "logo.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        let imageSize = 60.0
        imageView.frame = CGRect(x: (bounds.width / 2) - (imageSize / 2),
                                 y: (bounds.height / 2) - (imageSize / 2),
                                 width: imageSize,
                                 height: imageSize)
        addSubview(imageView)
    }
    
}
