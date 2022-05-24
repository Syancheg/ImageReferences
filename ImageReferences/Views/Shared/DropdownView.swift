//
//  DropdownView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import Foundation
import UIKit

class DropdownView: UIView {
    
    // MARK: - Private properties
    
    private var filterGroup: String = ""
    private var filters: [Filter] = []
    private var delegate: MainOutputDelegate?
    private let padding = 15.0
    private let buttonHeight = 50.0
    private let heigthLine = 50.0
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.cornerRadius()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.dropdownButtonBorder
        button.backgroundColor = .white
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0
        button.layer.shadowColor = UIColor.dropdownButtonShadow
        return button
    }()
    
    private var table: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 5
        table.layer.shadowOffset = CGSize(width: 5, height: 5)
        table.layer.shadowRadius = 20
        table.layer.shadowOpacity  = 0.3
        table.layer.shadowColor = UIColor.dropdownTableShadow
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.dropdownTableBorder
        return table
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        setupButton()
        setupConstraints()
    }
    
    convenience init(frame: CGRect, filterGroup: String, filterButton: String, filters: [Filter], delegate: MainOutputDelegate) {
        self.init(frame: frame)
        button.setTitle(filterButton, for: .normal)
        self.filterGroup = filterGroup
        self.filters = filters
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupButton() {
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
    }
    
    // MARK: - Actions
    
    private func buttonActive() {
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.layer.shadowOpacity = 0.5
    }
    
    private func buttonUnActive() {
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.layer.shadowOpacity = 0
    }
    
    @objc private func buttonAction() {
        if (table.superview != nil) {
            table.removeFromSuperview()
            buttonUnActive()
            return
        }
        buttonActive()
        var y = frame.origin.y + frame.height
        let height = Double(filters.count) * heigthLine
        if (frame.origin.y > 200) {
            y = frame.origin.y - height
        }
        table.frame = CGRect(x: 15, y: y, width: bounds.width - 30, height: height)
        superview?.addSubview(table)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
            
        ])
    }
}

extension DropdownView: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filters[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        button.setTitle(filters[indexPath.row].name, for: .normal)
        buttonUnActive()
        table.removeFromSuperview()
        delegate?.setFilter(with: [filterGroup: filters[indexPath.row].id])
    }
}
