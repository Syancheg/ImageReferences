//
//  FilterGroup.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

struct FilterGroup: Decodable {
    let id: Int
    let name: String
    let filters: [Filter]
}

extension FilterGroup {
    static var testData = [
        FilterGroup(id: 1, name: "Первая", filters: [
            Filter(id: 1, name: "Мужчина", group_id: 1),
            Filter(id: 2, name: "Женщина", group_id: 2),
            Filter(id: 3, name: "Рука", group_id: 3),
            Filter(id: 4, name: "Нога", group_id: 4)
        ])
    ]
}
