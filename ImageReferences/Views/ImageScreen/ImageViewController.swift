//
//  ImageViewController.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    var currentFilters: [Int:Int] = [:]
    var fullTime = 7

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    var timerView: TimerView = {
        let timer = TimerView()
        return timer
    }()
    
    var imageView: ImageView  = {
        let imageView = ImageView()
        return imageView
    }()
    
    var button: UIButton =  {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.03, green: 0.70, blue: 0.58, alpha: 1.00)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        return button
    }()

    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        timerView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerView)
        view.addSubview(imageView)
        view.addSubview(button)
        setupConstraints()
        timerView.fullTime = fullTime
    }
    
    @objc func startButtonAction() {
        button.setTitle("Остановить", for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.35, blue: 0.35, alpha: 1.00)
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        timerView.start()
    }
    
    @objc func stopButtonAction() {
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = UIColor(red: 0.03, green: 0.70, blue: 0.58, alpha: 1.00)
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        timerView.stop()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.timerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            self.timerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.timerView.heightAnchor.constraint(equalToConstant: 100.0),
            
            self.imageView.topAnchor.constraint(equalTo: self.timerView.bottomAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 1.6),
            
            self.button.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            self.button.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    
    
}
