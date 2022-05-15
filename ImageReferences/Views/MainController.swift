//
//  ViewController.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class MainController: UIViewController {
    
    private let presenter = MainPresenter()
    private var filterGroups: [FilterGroup] = []
    private var user: User?
    weak private var mainOutputDelegate: MainOutputDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Screen"
        presenter.setMainInputDelegate(mainInputDelegate: self)
        self.mainOutputDelegate = presenter
        guard self.mainOutputDelegate != nil else { return }
        self.mainOutputDelegate!.setupData()
        self.setupViews()
    }
    
    private func setupViews(){
        self.view.backgroundColor = .white
        self.setupLogo()
        self.setupSelects()
        self.setupButton()
    }
    
    private func setupLogo() {
        let logoView = LogoView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 145))
        self.view.addSubview(logoView)
    }
    
    private func setupSelects() {
        let view = UIView(frame: CGRect(x: 0, y: 245, width: self.view.bounds.width, height: 400))
        let heigth = 100.0
        var curHeigth = 0.0
        for index in 1...4 {
            let rect = CGRect(x: 0, y: curHeigth, width: self.view.bounds.width, height: heigth)
            let filterView = FilterView(frame: rect,
                                        filterGroupId: index,
                                        filters: filterGroups.first?.filters ?? [],
                                        delegate: presenter)
            view.addSubview(filterView)
            curHeigth += heigth
        }
        self.view.addSubview(view)
    }
    
    private func setupButton(){
        let button = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 75, y: self.view.bounds.height - 100 , width: 150, height: 50))
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.setTitle("Приступить", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        guard let delegate = self.mainOutputDelegate else { return }
        delegate.tapToDraw()
    }

}

extension MainController: MainInputDelegate {
    
    func setupUser(user: User) {
        self.user = user
    }
    
    func setupFilters(with filterGroups: [FilterGroup]) {
        self.filterGroups = filterGroups
    }
    
}

