//
//  DropdownView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import Foundation
import UIKit

class DropdownView: UIView {
    
    var filterGroupId: Int = 0
    var filters: [Filter] = []
    var delegate: MainOutputDelegate?
    
    var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setTitle("Начать", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.41, green: 0.54, blue: 1.00, alpha: 1.00).cgColor
        button.backgroundColor = .white
        
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0
        button.layer.shadowColor = UIColor(red: 0.31, green: 0.45, blue: 0.97, alpha: 1.00).cgColor
        
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
        table.layer.borderColor = UIColor(red: 0.88, green: 0.89, blue: 0.90, alpha: 1.00).cgColor
        table.layer.cornerRadius = 10
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        setupButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupConstraints()
    }
    
    convenience init(frame: CGRect, filterGroupId: Int, filters: [Filter], delegate: MainOutputDelegate) {
        self.init(frame: frame)
        self.filterGroupId = filterGroupId
        self.filters = filters
        self.delegate = delegate
    }
    
    private func setupButton() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }
    
    private func buttonActive() {
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.layer.shadowOpacity = 0.5
    }
    
    private func buttonUnActive() {
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.layer.shadowOpacity = 0
    }
    
    @objc func buttonAction() {
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
        print(button.frame.origin.y)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            self.button.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            self.button.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            
//            self.table.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 10),
//            self.table.heightAnchor.constraint(equalToConstant: 350),
//            self.table.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//            self.table.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
            
        ])
    }
}

extension DropdownView: UITableViewDelegate, UITableViewDataSource {


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
        self.button.setTitle(filters[indexPath.row].name, for: .normal)
        buttonUnActive()
        table.removeFromSuperview()
        delegate?.setFilter(with: [filterGroupId: filters[indexPath.row].id])
    }
}
