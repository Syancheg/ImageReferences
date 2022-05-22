//
//  ImageView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import Foundation
import UIKit

class ImageView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        backgroundColor = .black
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
