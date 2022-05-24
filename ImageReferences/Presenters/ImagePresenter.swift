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
    
    func setImageInputDelegate(imageInputDelegate: ImageInputDelegate) {
        self.imageInputDelegate = imageInputDelegate
    }
    
    func setupImage(with filter: [String : Int]){
        let service = ApiService()
        service.getImage(with: filter) { image in
            self.imageInputDelegate?.setupImage(url: image.url)
        }
    }
    
    
}

extension ImagePresenter: ImageOutputDelegate {
    func getImage(with filter: [String : Int]) {
        self.setupImage(with: filter)
    }
}
