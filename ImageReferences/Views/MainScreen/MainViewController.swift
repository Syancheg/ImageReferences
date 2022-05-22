//
//  MainViewController.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let presenter = MainPresenter()
    private var filterGroups: [FilterGroup] = []
    private var user: User?
    weak private var mainOutputDelegate: MainOutputDelegate?
    
    var logoView: LogoView = {
        let view = LogoView()
        return view
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var button: UIButton =  {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.03, green: 0.70, blue: 0.58, alpha: 1.00)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выберите категории"
        presenter.setMainInputDelegate(mainInputDelegate: self)
        self.mainOutputDelegate = presenter
        guard self.mainOutputDelegate != nil else { return }
        self.mainOutputDelegate!.setupData()
        self.setupViews()
    }
    
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
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.logoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.logoView.heightAnchor.constraint(equalToConstant: 100),
            self.logoView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.logoView.bottomAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 2),
            
            self.button.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonAction(sender: UIButton!) {
        guard let delegate = self.mainOutputDelegate else { return }
        let imageViewContoller = ImageViewController()
        imageViewContoller.currentFilters = delegate.currentFilter
        imageViewContoller.fullTime = 43
        self.navigationController?.pushViewController(imageViewContoller, animated: true)
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
                let drop = DropdownView(frame: .zero, filterGroupId: element.id, filterButton: element.name, filters: element.filters, delegate: presenter)
                self.stackView.addArrangedSubview(drop)
            }
        }
        
    }
    
}

