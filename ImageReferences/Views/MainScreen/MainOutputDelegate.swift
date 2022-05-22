//
//  MainOutputDelegate.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

protocol MainOutputDelegate: AnyObject {
    func setupData()
    func setFilter(with index: [Int:Int])
    var currentFilter: [Int: Int] { get }
}
