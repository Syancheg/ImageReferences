//
//  ImageInputDelegate.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation
import UIKit

protocol ImageInputDelegate: AnyObject {
    func setupImage(url: String)
    func alertError()
}
