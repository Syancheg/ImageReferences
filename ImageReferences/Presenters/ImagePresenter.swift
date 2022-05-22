//
//  ImagePresenter.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation
import UIKit

class ImagePresenter {
    weak private var imageInputDelegate:  ImageInputDelegate?
    private var image: Image = Image.testData
    
    func setImageInputDelegate(imageInputDelegate: ImageInputDelegate) {
        self.imageInputDelegate = imageInputDelegate
    }
    
    
}

extension ImagePresenter: ImageOutputDelegate {
    func getImage(with filter: [Int : Int]) {
        self.imageInputDelegate?.setupImage(url: image.url)
    }
}
