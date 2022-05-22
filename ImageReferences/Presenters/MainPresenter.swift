//
//  MainPresenter.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

class MainPresenter {
    
    weak private var mainInputDelegate: MainInputDelegate?
    private var filters = FilterGroup.testData
    private var currentFilters: [Int:Int] = [:]
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
    
    
    var currentFilter: [Int : Int] {
        get {
            return self.currentFilters
        }
    }
    
    func setFilter(with index: [Int : Int]) {
        self.currentFilters = self.currentFilters.merging(index) { (_, new) in new }
    }

}
