//
//  MainOutputDelegate.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

protocol MainOutputDelegate: AnyObject {
    func setupData()
    func setFilter(with filters: [String:Int])
    func setTime(sec: Int)
    var currentFilter: [String: Int] { get }
    var currentTime: Int { get }
}
