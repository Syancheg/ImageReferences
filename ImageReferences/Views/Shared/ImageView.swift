//
//  ImageView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import UIKit

class ImageView: UIView {
    
    // MARK: - Properties
    
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
    
    // MARK: - Private properties
    
    private var activity: UIActivityIndicatorView?
    private var gestureRecognizer: UIPinchGestureRecognizer?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupView() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomImage))
        clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(pinchGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setupActivity()
        setupConstraints()
    }
    
    private func setupActivity() {
        activity = UIActivityIndicatorView(style: .large)
        guard let activity = activity else { return }
        imageView.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
    }
    
    // MARK: - Actions
    
    @objc private func zoomImage(recognizer: UIPinchGestureRecognizer) {
        guard let view = recognizer.view else { return }
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        if frame.width > view.frame.width {
            view.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        }
        recognizer.scale = 1.0
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        guard let activity = activity else { return }
        
        NSLayoutConstraint.activate([
            activity.topAnchor.constraint(equalTo: imageView.topAnchor),
            activity.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            activity.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            activity.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
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
            self.image = UIImage(systemName: "photo.fill")
        }
    }
    
}
