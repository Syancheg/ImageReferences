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
        button.backgroundColor = UIColor.butttonStart
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
        button.backgroundColor = UIColor.butttonStart
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        timerView.stop()
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timerView.topAnchor.constraint(equalTo: view.topAnchor, constant: _headerPadding),
            timerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            timerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            timerView.heightAnchor.constraint(equalToConstant: timerViewHeigth),
            
            imageView.topAnchor.constraint(equalTo: timerView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height / imageProportions),
            
            button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -_footerPadding),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: _buttonPadding),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -_buttonPadding),
            button.heightAnchor.constraint(equalToConstant: _buttonHeight)

        ])
    }
    
}

extension ImageViewController: ImageInputDelegate {
    
    func setupImage(url: String) {
        imageView.imageUrl = url
    }
}
