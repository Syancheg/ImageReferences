//
//  MainPresenter.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

class MainPresenter {
    
    weak private var mainInputDelegate: MainInputDelegate?
    private var currentFilters: [String:Int] = [:]
    private var user = User.testData
    
    func setMainInputDelegate(mainInputDelegate: MainInputDelegate?) {
        self.mainInputDelegate = mainInputDelegate
    }
    
    private func loadTestData() {
        let service = ApiService()
        service.getFilters { filters in
            guard let filters = filters else { return }
            if let delegate = self.mainInputDelegate {
                delegate.setupFilters(with: filters)
                delegate.setupUser(user: self.user)
            }
        }
    }
    
}

extension MainPresenter: MainOutputDelegate {
    func setupData() {
        self.loadTestData()
    }
    
    
    var currentFilter: [String : Int] {
        get {
            return self.currentFilters
        }
    }
    
    func setFilter(with index: [String : Int]) {
        self.currentFilters = self.currentFilters.merging(index) { (_, new) in new }
    }

}
