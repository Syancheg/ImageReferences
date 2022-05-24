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
    private let filterViewProportions = 2.0
    
    private let presenter = MainPresenter()
    private var filterGroups: [FilterGroup] = []
    private var user: User?
    weak private var mainOutputDelegate: MainOutputDelegate?
    
    private var logoView: LogoView = {
        let view = LogoView()
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var button: UIButton =  {
        let button = UIButton()
        button.setTitle(_textStart, for: .normal)
        button.tintColor = .white
        button.cornerRadius()
        button.backgroundColor = UIColor.butttonStart
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = _textMainTitle
        presenter.setMainInputDelegate(mainInputDelegate: self)
        mainOutputDelegate = presenter
        guard let mainOutputDelegate = mainOutputDelegate else { return }
        mainOutputDelegate.setupData()
        setupViews()
    }
    
    // MARK: - Private Functions
    
    private func setupViews(){
        view.backgroundColor = .white
        setupLogo()
        setupSelects()
        setupButton()
        setupConstraints()
    }
    
    private func setupLogo() {
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
    }
    
    private func setupSelects() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    
    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
    
    // MARK: - Private Constraints
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: _headerPadding),
            logoView.heightAnchor.constraint(equalToConstant: logoHeight),
//            logoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
//            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height / filterViewProportions),
            
            button.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -_footerPadding),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: _buttonPadding),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -_buttonPadding),
            button.heightAnchor.constraint(equalToConstant: _buttonHeight)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func buttonAction(sender: UIButton!) {
        guard let delegate = mainOutputDelegate else { return }
        let imageViewContoller = ImageViewController()
        imageViewContoller.currentFilters = delegate.currentFilter
        imageViewContoller.fullTime = 43
        guard let navigationController = self.navigationController else { return }
        navigationController.pushViewController(imageViewContoller, animated: true)
    }

}

extension MainViewController: MainInputDelegate {
    
    func setupUser(user: User) {
        self.user = user
    }
    
    func setupFilters(with filterGroups: [FilterGroup]) {
        self.filterGroups = filterGroups
        for (_, element) in self.filterGroups.enumerated() {
            DispatchQueue.main.async { [self] in
                let drop = DropdownView(frame: .zero, filterGroup: element.code, filterButton: element.name, filters: element.filters, delegate: presenter)
                self.stackView.addArrangedSubview(drop)
            }
        }
        
    }
    
}

