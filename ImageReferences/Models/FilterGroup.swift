//
//  FilterGroup.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

struct FilterGroup {
    var id: Int
    var name: String
    var filters: [Filter]
}

extension FilterGroup {
    static var testData = [
        FilterGroup(id: 1, name: "Первая", filters: [
            Filter(id: 1, name: "Мужчина"),
            Filter(id: 2, name: "Женщина"),
            Filter(id: 3, name: "Рука"),
            Filter(id: 4, name: "Нога")
        ])
    ]
}
