//
//  UINavigationController+Extension.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 29.05.2022.
//

import UIKit

extension UINavigationController {
    open override var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}
