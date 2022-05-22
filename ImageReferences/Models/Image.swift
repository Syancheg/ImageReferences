//
//  Image.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation

struct Image {
    var id: Int
    var url: String
    var gender: Int
    var cloth: Int
    var pose: Int
    var view: Int
}

extension Image {
    static let testData = Image(id: 1,
                                url: "https://kartinki-raskraski.ru/wp-content/uploads/2021/05/78f6360618746215afaf6895071564c5-768x929.jpg",
                                gender: 2,
                                cloth: 1,
                                pose: 1,
                                view: 1)
}
