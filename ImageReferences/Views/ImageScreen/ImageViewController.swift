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
    private let buttonHeigth = 50.0
    private let paddingBottom = 15.0
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
    
    // MARK: - Override properties
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        presenter.setImageInputDelegate(imageInputDelegate: self)
        imageOutputDelegate = presenter
        guard let delegate = imageOutputDelegate else { return }
        delegate.getImage(with: self.currentFilters)
        setupView()
    }
    
    // MARK: - Private Functions

    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        timerView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        button.setTitle("Начать", for: .normal)
        timerView.fullTime = fullTime
        timerView.delegate = self
        view.addSubview(timerView)
        view.addSubview(imageView)
        view.addSubview(button)
        setupConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func startButtonAction() {
        button.setTitle("Остановить", for: .normal)
        button.backgroundColor = UIColor.buttonStop
        button.removeTarget(nil, action: nil, for: .allEvents)
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        timerView.start()
    }
    
    @objc private func stopButtonAction() {
        button.setTitle("Начать", for: .normal)
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
            
            button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -paddingBottom),
            button.leftAnchor.constraint(equalTo: margins.leftAnchor),
            button.rightAnchor.constraint(equalTo: margins.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeigth)

        ])
    }
    
}

extension ImageViewController: ImageInputDelegate {
    
    func alertError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(
                title: "Sorry(",
                message: "С такими фильтрами картинок пока нет, но они будут позже)",
                preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                guard let navigationController = self.navigationController else { return }
                navigationController.popToRootViewController(animated: true)
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            button.isEnabled = false
            button.backgroundColor = UIColor.buttonDisabled
        }
    }
    
    func setupImage(url: String) {
        imageView.imageUrl = url
    }
}

extension ImageViewController: TimerOutputDelegate {
    func showAlertTimer() {
        let alert = UIAlertController(title: "Время вышло!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        button.isEnabled = false
        button.backgroundColor = UIColor.buttonDisabled
    }
}
