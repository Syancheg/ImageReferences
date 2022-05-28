//
//  MainPresenter.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

class MainPresenter {
    
    weak var mainInputDelegate: MainInputDelegate?
    private var currentFilters: [String:Int] = [:]
    private var countFullFulters = 0
    private var time = 30
    private let timers = [30, 60, 120, 180]
    private var user = User.testData
    
    private func loadData() {
        let service = ApiService()
        guard let delegate = self.mainInputDelegate else { return }
        service.getFilters { filters in
            guard let filters = filters else {
                delegate.alertError()
                return
            }
            self.countFullFulters = filters.count
            delegate.setupFilters(with: filters)
            delegate.setupUser(user: self.user)
            delegate.setupTimers(timers: self.timers)
            delegate.stopActivity()
        }
    }
    
}

extension MainPresenter: MainOutputDelegate {
    
    var currentFilter: [String : Int] {
        get {
            return currentFilters
        }
    }
    
    var currentTime: Int {
        get {
            return time
        }
    }
    
    func setTime(sec: Int) {
        time = sec
    }
    
    func setupData() {
        self.loadData()
    }
    
    func setFilter(with index: [String : Int]) {
        currentFilters = currentFilters.merging(index) { (_, new) in new }
        if countFullFulters == currentFilters.count {
            guard let delegate = mainInputDelegate else { return }
            delegate.activateButton()
        }
    }

}
