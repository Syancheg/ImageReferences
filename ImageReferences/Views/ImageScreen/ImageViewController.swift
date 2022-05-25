//
//  ImageViewController.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - Properties
    
    var currentFilters: [String:Int] = [:]
    var fullTime = 0
    
    // MARK: - Private properties
    
    private let timerViewHeigth = 100.0
    private let imageProportions = 1.6
    private let presenter = ImagePresenter()
    weak private var imageOutputDelegate: ImageOutputDelegate?
    
    private var timerView: TimerView = {
        let timer = TimerView()
        return timer
    }()
    
    private var imageView: ImageView  = {
        let imageView = ImageView()
        return imageView
    }()
    
    private var button: UIButton =  {
        let button = UIButton()
        button.tintColor = .white
        button.cornerRadius()
        button.backgroundColor = UIColor.buttonStart
        return button
    }()
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.setImageInputDelegate(imageInputDelegate: self)
        imageOutputDelegate = presenter
        guard imageOutputDelegate != nil else { return }
        imageOutputDelegate!.getImage(with: self.currentFilters)
        setupView()
    }
    
    // MARK: - Private Functions

    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        timerView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        button.setTitle(_textStart, for: .normal)
        view.addSubview(timerView)
        view.addSubview(imageView)
        view.addSubview(button)
        setupConstraints()
        timerView.fullTime = fullTime
    }
    
    // MARK: - Actions
    
    @objc private func startButtonAction() {
        button.setTitle(_textStop, for: .normal)
        button.backgroundColor = UIColor.buttonStop
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        timerView.start()
    }
    
    @objc private func stopButtonAction() {
        button.setTitle(_textStart, for: .normal)
        button.backgroundColor = UIColor.buttonStart
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        timerView.stop()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: margins.topAnchor),
            timerView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            timerView.heightAnchor.constraint(equalToConstant: timerViewHeigth),
            
            imageView.topAnchor.constraint(equalTo: timerView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height / imageProportions),
            
            button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -_bottomPadding),
            button.leftAnchor.constraint(equalTo: margins.leftAnchor),
            button.rightAnchor.constraint(equalTo: margins.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: _buttonHeight)

        ])
    }
    
}

extension ImageViewController: ImageInputDelegate {
    
    func alertError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: _imageAlertTitle, message: _imageAlertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            button.isEnabled = false
            button.backgroundColor = UIColor.buttonDisabled
        }
    }
    
    func setupImage(url: String) {
        imageView.imageUrl = url
    }
}
