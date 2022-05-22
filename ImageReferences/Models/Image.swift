//
//  Image.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation

struct Image: Decodable {
    var id: Int
    var url: String
    var gender_id: Int
    var cloth_id: Int
    var pose_id: Int
    var view_id: Int
}

extension Image {
    static let testData = Image(id: 1,
                                url: "https://kartinki-raskraski.ru/wp-content/uploads/2021/05/78f6360618746215afaf6895071564c5-768x929.jpg",
                                gender_id: 2,
                                cloth_id: 1,
                                pose_id: 1,
                                view_id: 1)
}
