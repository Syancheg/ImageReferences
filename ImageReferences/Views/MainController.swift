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
        presenter.setMainInputDelegate(mainInputDelegate: self)
        self.mainOutputDelegate = presenter
        guard self.mainOutputDelegate != nil else { return }
        self.mainOutputDelegate!.setupData()
    }

}

extension MainController: MainInputDelegate {
    
    func setupUser(user: User) {
        self.user = user
    }
    
    func setFilter(with index: [Int : Int]) {
        
    }
    
    func setupFilters(with filterGroups: [FilterGroup]) {
        self.filterGroups = filterGroups
    }
    
}

