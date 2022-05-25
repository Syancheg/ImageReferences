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
    private var time = 30
    private let timers = [30, 60, 120, 180]
    private var user = User.testData
    
    func setMainInputDelegate(mainInputDelegate: MainInputDelegate?) {
        self.mainInputDelegate = mainInputDelegate
    }
    
    private func loadData() {
        let service = ApiService()
        service.getFilters { filters in
            guard let filters = filters else { return }
            if let delegate = self.mainInputDelegate {
                delegate.setupFilters(with: filters)
                delegate.setupUser(user: self.user)
                delegate.setupTimers(timers: self.timers)
                delegate.stopActivity()
            }
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
    }

}
