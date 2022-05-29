//
//  LogoView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class LogoView: UIView {
    
    // MARK: - Private properties
    
    private let imagePadding = 10.0
    private let circleSize = 120.0
    private let logoSize = 80.0
    
    private var imageLogo: UIImageView = {
        let image = UIImage(named: "logo.png")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private var cirleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 60
        view.backgroundColor = UIColor.circleLogo
        return view
    }()
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        cirleView.translatesAutoresizingMaskIntoConstraints = false
        cirleView.addSubview(imageLogo)
        addSubview(cirleView)
        setupConstraints()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cirleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cirleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cirleView.widthAnchor.constraint(equalToConstant: circleSize),
            cirleView.heightAnchor.constraint(equalToConstant: circleSize),

            imageLogo.centerXAnchor.constraint(equalTo: cirleView.centerXAnchor),
            imageLogo.centerYAnchor.constraint(equalTo: cirleView.centerYAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: logoSize),
            imageLogo.heightAnchor.constraint(equalToConstant: logoSize)

        ])
    }
    
}
