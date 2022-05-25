//
//  ImageOutputDelegate.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation

protocol ImageOutputDelegate: AnyObject {
    func getImage(with filter: [String:Int])
}
