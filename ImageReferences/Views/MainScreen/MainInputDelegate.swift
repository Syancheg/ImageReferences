//
//  MainInputDelegate.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

protocol MainInputDelegate: AnyObject {
    func setupUser(user: User)
    func setupFilters(with filterGruops: [FilterGroup])
    func setupTimers(timers: [Int])
    func stopActivity()
    func alertError()
}
 
