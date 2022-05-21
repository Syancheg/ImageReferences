//
//  TimerView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import Foundation
import UIKit

class TimerView: UIView {
    
    let padding = 15.0
    let labelHeight = 60.0
    let progressHeight = 10.0
    
    let fullTime: Int = 0
    var currentTime: Int = 0
    var progress: Double = 0.0
    var progressView = UIProgressView()
    var timer: Timer?
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTimer()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTimer()
        setupView()
    }
    
    private func setupView() {
        setupLabel()
        setupProgressView()
        setupConstraints()
    }
    
    private func setupLabel() {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    private func setupProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.34
        addSubview(progressView)
    }
    
    private func setupTimer() {
        self.label.text = "0:00"
        
//        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [ weak self ] timer in
//            guard let self = self else { return }
//            guard self.progress < 1 else {
//                timer.invalidate()
//                return
//            }
//            let newProgress = self.progress + 0.05
//            if self.progress >= 1 {
////                self.stop()
//                return
//            }
//            self.progress = newProgress
//        })
        print("timer")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding),
            self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.padding),
            self.label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.padding),
            self.label.heightAnchor.constraint(equalToConstant: self.labelHeight),
            
            self.progressView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 0),
            self.progressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.padding),
            self.progressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.padding),
            self.progressView.heightAnchor.constraint(equalToConstant: self.progressHeight),
            
        ])
    }
    
    
    
}
