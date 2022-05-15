//
//  User.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import Foundation

struct User {
    var id: Int
    var name: String
    var countImage: Int
}

extension User {
    static var testData = User(id: 1, name: "TestUser", countImage: 5)
}
