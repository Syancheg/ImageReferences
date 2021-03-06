//
//  TimerView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import UIKit

protocol TimerOutputDelegate: AnyObject {
    func showAlertTimer()
}

class TimerView: UIView {
    
    // MARK: - Private properties

    private let padding = 15.0
    private let labelHeight = 60.0
    private let progressHeight = 10.0
    private let fontSize = 40.0
    private var currentTime = 0
    private var progressStep: Float = 0.0
    private var progressView = UIProgressView()
    private var timer: Timer?
    private let label = UILabel()
    
    // MARK: - Properties
    
    var delegate: TimerOutputDelegate?
    
    var fullTime = 0 {
        didSet {
            setTimeToLabel(sec: fullTime)
            currentTime = fullTime
            setProgressStep()
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Functions
   
    func start() {
        setupTimer()
    }
    
    func stop() {
        if timer != nil {
            timer!.invalidate()
        }
    }
    
    // MARK: - Setup Views
    
    private func setupView() {
        setupLabel()
        setupProgressView()
        setupConstraints()
    }
    
    private func setupLabel() {
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    private func setupProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
    }
    
    // MARK: - Set Timer and Progress
    
    private func setupTimer() {
        timer = nil
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
    }
    
    private func setTimeToLabel(sec: Int) {
        let min = Int(sec / 60)
        let sec = Int(sec % 60)
        var strTime: String
        if sec < 10 {
            strTime = "\(min):0\(sec)"
        } else {
            strTime = "\(min):\(sec)"
        }
        self.label.text = strTime
    }
    
    private func setProgressStep() {
        progressStep = 1.0 / Float(fullTime)
    }
    
    @objc private func updateTimer() {
        currentTime -= 1
        setTimeToLabel(sec: currentTime)
        if(progressView.progress < 1) {
            progressView.progress += progressStep
        }
        if (currentTime <= 0){
            stop()
            guard let delegate = delegate else { return }
            delegate.showAlertTimer()
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.heightAnchor.constraint(equalToConstant: labelHeight),
            
            progressView.topAnchor.constraint(equalTo: label.bottomAnchor),
            progressView.leftAnchor.constraint(equalTo: leftAnchor),
            progressView.rightAnchor.constraint(equalTo: rightAnchor),
            progressView.heightAnchor.constraint(equalToConstant: progressHeight),
            
        ])
    }
    
}
