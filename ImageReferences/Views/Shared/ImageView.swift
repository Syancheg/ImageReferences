//
//  ImageView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import Foundation
import UIKit

class ImageView: UIView {
    
    private var activity: UIActivityIndicatorView?
    private var gestureRecognizer: UIPinchGestureRecognizer?
    
    var imageUrl: String = "" {
        didSet {
            imageView.downloadImage(urlPath: self.imageUrl)
            if self.activity != nil {
                DispatchQueue.main.async {
                    self.activity!.stopAnimating()
                }
            }
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setupConstraints()
        setupActivity()
    }
    
    private func setupActivity() {
        activity = UIActivityIndicatorView(style: .large)
        addSubview(activity!)
        activity!.startAnimating()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        gestureRecognizer = UIPinchGestureRecognizer(target: self.imageView, action: #selector(ImageView.imageZoom))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(gestureRecognizer!)
    }
    
    @objc func imageZoom() {
        print("zoooom")
    }
    
    
    
}

extension UIImageView{
    
    func downloadImage(urlPath: String?){
        if let urlPath = urlPath, let url = URL(string: urlPath) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, respons, error) in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            task.resume()
        } else {
            self.image = UIImage(systemName: "photo")!
        }
    }
    
}
