//
//  Dropdown.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 15.05.2022.
//

import Foundation
import UIKit

class Dropdown: UIView {
    
    let padding = 15

    
    var filterGroupId: Int = 0
    var filters: [Filter] = []
    var delegate: MainOutputDelegate?
    
    
    static let buttonImageUp = UIImage(systemName: "chevron.up")
    static let buttonImageDown = UIImage(systemName: "chevron.down")
    static let buttonBorderColor = UIColor(red: 0.41, green: 0.54, blue: 1.00, alpha: 1.00).cgColor
    static let buttonShadowColor =  UIColor(red: 0.31, green: 0.45, blue: 0.97, alpha: 1.00).cgColor
    static let tableBorderColor = UIColor(red: 0.88, green: 0.89, blue: 0.90, alpha: 1.00).cgColor
    static let textColor = UIColor(red: 0.35, green: 0.39, blue: 0.45, alpha: 1.00)
    
    var filterButton: UIButton = {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Выбрать"
        configuration.image = buttonImageDown
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = textColor
        configuration.imagePlacement = .trailing
        configuration.titleAlignment = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.layer.borderWidth = 1
        button.layer.borderColor = buttonBorderColor
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0
        button.layer.shadowColor = buttonShadowColor
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var table: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 15
        table.layer.shadowOffset = CGSize(width: 5, height: 5)
        table.layer.shadowRadius = 20
        table.layer.shadowOpacity  = 0.3
        table.layer.shadowColor = UIColor(red: 0.11, green: 0.18, blue: 0.37, alpha: 1.00).cgColor
        table.layer.borderWidth = 1
        table.layer.borderColor = tableBorderColor
        table.layer.cornerRadius = 10
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, filterGroupId: Int, filters: [Filter], delegate: MainOutputDelegate?){
        self.init(frame: frame)
        self.filterGroupId = filterGroupId
        self.filters += filters
        self.delegate = delegate
        table.delegate = self
        table.dataSource = self
        setupView()
    }
    
    private func setupView(){
        filterButton.setImage(Dropdown.buttonImageDown, for: .normal)
        filterButton.frame = CGRect(x: self.padding, y: self.padding, width: Int(bounds.width - 30.0), height: Int(bounds.height - 30))
        addSubview(filterButton)
    }
    
    private func buttonActive() {
        filterButton.setImage(Dropdown.buttonImageUp, for: .normal)
        filterButton.layer.shadowOpacity = 0.5
    }
    
    private func buttonUnActive() {
        filterButton.setImage(Dropdown.buttonImageDown, for: .normal)
        filterButton.layer.shadowOpacity = 0
    }

    @objc func buttonAction(sender: UIButton!) {
        if (table.superview != nil) {
            table.removeFromSuperview()
            buttonUnActive()
            return
        }
        buttonActive()
        var y = self.frame.origin.y + self.frame.height
        if (self.frame.origin.y > 200) {
            y = self.frame.origin.y - 200
        }
        table.frame = CGRect(x: 15, y: y, width: bounds.width - 30, height: 200)
        self.superview?.addSubview(table)
    }
}

extension Dropdown: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.filters[indexPath.row].name
        cell.textLabel?.textColor = Dropdown.textColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filterButton.setTitle(filters[indexPath.row].name, for: .normal)
        buttonUnActive()
        table.removeFromSuperview()
        delegate?.setFilter(with: [filterGroupId: filters[indexPath.row].id])
    }



}
