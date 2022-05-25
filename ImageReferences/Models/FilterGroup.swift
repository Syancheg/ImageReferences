//
//  FilterGroup.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

struct FilterGroup: Decodable {
    let id: Int
    let code: String
    let name: String
    let filters: [Filter]
}
