//
//  DropdownTableViewCell.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 28.05.2022.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupSeparator(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 15, y: bounds.height - 1, width: bounds.width + 15, height: 1.0)
        bottomLine.backgroundColor = UIColor.dropdownTableBorders.cgColor
        layer.addSublayer(bottomLine)
    }

}
