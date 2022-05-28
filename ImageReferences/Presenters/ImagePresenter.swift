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
        guard let delegate = imageInputDelegate else { return }
        service.getImage(with: filter) { image in
            guard let image = image else {
                delegate.alertError()
                return
            }
            delegate.setupImage(url: image.url)
        }
    }
    
    
}

extension ImagePresenter: ImageOutputDelegate {
    func getImage(with filter: [String : Int]) {
        self.setupImage(with: filter)
    }
}
