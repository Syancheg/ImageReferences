//
//  LogoView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class LogoView: UIView {
    
    
    var imageLogo: UIImageView = {
        let image = UIImage(named: "logo.png")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var cirleView: UIView = {
        let view = UIView()
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: 25, y: 25),
            radius: CGFloat(50),
            startAngle: CGFloat(0),
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor(red: 0.99, green: 0.65, blue: 0.29, alpha: 1.00).cgColor
        view.layer.addSublayer(shapeLayer)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        cirleView.translatesAutoresizingMaskIntoConstraints = false
        cirleView.addSubview(imageLogo)
        addSubview(cirleView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.cirleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.cirleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.cirleView.widthAnchor.constraint(equalToConstant: 50.0),
            self.cirleView.heightAnchor.constraint(equalToConstant: 50.0),

            self.imageLogo.centerXAnchor.constraint(equalTo: self.cirleView.centerXAnchor),
            self.imageLogo.centerYAnchor.constraint(equalTo: self.cirleView.centerYAnchor),
            self.imageLogo.widthAnchor.constraint(equalTo: self.cirleView.widthAnchor, constant: 10),
            self.imageLogo.heightAnchor.constraint(equalTo: self.cirleView.heightAnchor, constant: 10)
        ])
    }
    
}
