//
//  MainViewController.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let logoHeight = 100.0
    private let buttonHeigth = 50.0
    private let bottomPadding = 15.0
    private let stackViewHeigth = 330.0
    
    private let presenter = MainPresenter()
    private var filterGroups: [FilterGroup] = []
    private var user: User?
    private var timers: [Int] = []
    private var timerButtons: [UIButton] = []
    weak private var mainOutputDelegate: MainOutputDelegate?
    private var activity: UIActivityIndicatorView?
    
    private var logoView: LogoView = {
        let view = LogoView()
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var button: UIButton =  {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.tintColor = .white
        button.cornerRadius()
        button.isEnabled = false
        button.backgroundColor = UIColor.buttonDisabled
        return button
    }()
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор категории"
        presenter.mainInputDelegate = self
        mainOutputDelegate = presenter
        guard let mainOutputDelegate = mainOutputDelegate else { return }
        mainOutputDelegate.setupData()
        setupViews()
    }
    
    // MARK: - Private Functions
    
    private func setupViews(){
        view.backgroundColor = .white
        setupActivity()
        setupLogo()
        setupSelects()
        setupButton()
        setupTimerButtons()
        setupConstraints()
    }
    
    private func setupLogo() {
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
    }
    
    private func setupActivity() {
        activity = UIActivityIndicatorView(style: .large)
        guard let activity = activity else { return }
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
    }
    
    private func setupSelects() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    
    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    private func setupTimerButtons() {
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerStackView)
    }
    
    // MARK: - Private Constraints
    
    private func setupConstraints(){
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: margins.topAnchor),
            logoView.heightAnchor.constraint(equalToConstant: logoHeight),
            logoView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            logoView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: stackViewHeigth),
            
            timerStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: bottomPadding),
            timerStackView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            timerStackView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            timerStackView.heightAnchor.constraint(equalToConstant: buttonHeigth),
            
            button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -bottomPadding),
            button.leftAnchor.constraint(equalTo: margins.leftAnchor),
            button.rightAnchor.constraint(equalTo: margins.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeigth)
        ])
        
        guard let activity = activity else { return }
        
        NSLayoutConstraint.activate([
            activity.topAnchor.constraint(equalTo: margins.topAnchor),
            activity.leftAnchor.constraint(equalTo: margins.leftAnchor),
            activity.rightAnchor.constraint(equalTo: margins.rightAnchor),
            activity.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
    }
    
    // MARK: - Actions
    
    @objc private func buttonAction() {
        guard let delegate = mainOutputDelegate else { return }
        let imageViewContoller = ImageViewController()
        imageViewContoller.currentFilters = delegate.currentFilter
        imageViewContoller.fullTime = delegate.currentTime
        guard let navigationController = self.navigationController else { return }
        navigationController.pushViewController(imageViewContoller, animated: true)
    }
    
    @objc private func timerButtonAction(sender: UIButton!) {
        guard let button = sender, let mainOutputDelegate = mainOutputDelegate else { return }
        mainOutputDelegate.setTime(sec: button.tag)
        for timerButton in timerButtons {
            timerButton.backgroundColor = .white
            timerButton.setTitleColor(.black, for: .normal)
        }
        button.backgroundColor = UIColor.dropdownButtonBorder
        button.setTitleColor(.white, for: .normal)
    }

}

extension MainViewController: MainInputDelegate {
    func activateButton() {
        button.isEnabled = true
        button.backgroundColor = UIColor.buttonStart
        
    }
    
    
    func alertError() {
        DispatchQueue.main.async { [self] in
            guard let activity = self.activity else { return }
            activity.stopAnimating()
            let alert = UIAlertController(
                title: "Ошибка сети!",
                message: "В данный момент приложение не может продолжить свою работу",
                preferredStyle: .alert
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.async { [self] in
            guard let activity = self.activity else { return }
            activity.stopAnimating()
        }
    }
    
    func setupTimers(timers: [Int]) {
        for time in timers {
            DispatchQueue.main.async { [self] in
                let button = UIButton()
                button.setTitle(String(time), for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.layer.borderWidth = 1
                button.layer.cornerRadius = 50.0 / 2.0
                button.layer.borderColor = UIColor.dropdownButtonBorder.cgColor
                button.tag = time
                button.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant: buttonHeigth),
                    button.widthAnchor.constraint(equalToConstant: buttonHeigth),
                ])
                self.timerButtons.append(button)
                self.timerStackView.addArrangedSubview(button)
            }
            
        }
    }
    
    
    func setupUser(user: User) {
        self.user = user
    }
    
    func setupFilters(with filterGroups: [FilterGroup]) {
        self.filterGroups = filterGroups
        for element in filterGroups {
            DispatchQueue.main.async { [self] in
                let drop = DropdownView(
                    frame: .zero,
                    filterGroup: element.code,
                    filterButton: element.name,
                    filters: element.filters,
                    delegate: presenter)
                self.stackView.addArrangedSubview(drop)
            }
        }
        
    }
    
}

