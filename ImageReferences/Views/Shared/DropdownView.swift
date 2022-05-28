//
//  DropdownView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 21.05.2022.
//

import UIKit

protocol DropdownOutputProtocol: AnyObject {
    
}

class DropdownView: UIView {
    
    // MARK: - Private properties
    
    private var filterGroup: String = ""
    private var filters: [Filter] = []
    private var delegate: MainOutputDelegate?
    private var tableHeigth = 0.0
    private let paddingTop = 30.0
    private let buttonHeight = 50.0
    private let heigthLine = 45.0
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.cornerRadius()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.dropdownButtonBorder.cgColor
        button.backgroundColor = .white
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0
        button.layer.shadowColor = UIColor.dropdownButtonShadow.cgColor
        return button
    }()
    
    private var table: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 5
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.dropdownTableBorders.cgColor
        return table
    }()
    
    private var overlayView: UIView = {
        let view = UIView()
        view.layer.opacity = 0
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        setupButton()
        setupConstraints()
    }
    
    convenience init(frame: CGRect, filterGroup: String, filterButton: String, filters: [Filter], delegate: MainOutputDelegate) {
        self.init(frame: frame)
        button.setTitle(filterButton, for: .normal)
        self.filterGroup = filterGroup
        self.filters = filters
        self.delegate = delegate
        setupOverlay()
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
    
    private func setupOverlay() {
        guard let superview = superview else { return }
        overlayView.frame = CGRect(
            x: -superview.frame.origin.x,
            y: -superview.frame.origin.y,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOverlay))
        overlayView.addGestureRecognizer(tap)
    }
    
    private func viewOverlay() {
        if overlayView.frame.height == 0.0 {
            setupOverlay()
        }
        guard let superview = superview else { return }
        superview.addSubview(overlayView)
        UIView.animate(withDuration: 0.3) {
            self.overlayView.layer.opacity = 0.3
        }
    }
    
    private func deleteOverlay() {
        if overlayView.superview != nil {
            UIView.animate(
                withDuration: 0.3) {
                    self.overlayView.layer.opacity = 0.0
                } completion: { stop in
                    self.overlayView.removeFromSuperview()
                }
        }
    }
    
    @objc private func buttonAction() {
        if table.superview != nil {
            closeAnimation()
            return
        }
        buttonActive()
        openAnimation()
    }
    
    @objc func tapOverlay() {
        closeAnimation()
    }
    
    // MARK: - Animations
    
    private func openAnimation() {
        guard let superview = superview else { return }
        var y = frame.origin.y
        tableHeigth = Double(filters.count) * heigthLine
        if frame.origin.y < 150 {
            y += frame.height
            table.frame = CGRect(x: 0, y: y, width: bounds.width, height: 0)
        } else {
            y += paddingTop - 7
            table.frame = CGRect(x: 0, y: y, width: bounds.width, height: 0)
            y -= self.tableHeigth
            
        }
        viewOverlay()
        superview.addSubview(table)
        UIView.animate(withDuration: 0.3) {
            self.table.frame = CGRect(x: 0, y: y, width: self.bounds.width, height: self.tableHeigth)
        }
        
    }
    
    func closeAnimation() {
        var y = frame.origin.y
        if frame.origin.y < 150 {
            y += frame.height
        } else {
            y += paddingTop - 7
        }
        deleteOverlay()
        UIView.animate(withDuration: 0.3) {
            self.table.frame = CGRect(x: 0, y: y, width: self.bounds.width, height: 0)
        } completion: { stop in
            self.table.removeFromSuperview()
            self.buttonUnActive()
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }
}

extension DropdownView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DropdownTableViewCell()
        cell.textLabel?.text = filters[indexPath.row].name
        if indexPath.row != filters.count - 1 {
            cell.setupSeparator()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        button.setTitle(filters[indexPath.row].name, for: .normal)
        closeAnimation()
        guard let delegate = delegate else { return }
        delegate.setFilter(with: [filterGroup: filters[indexPath.row].id])
    }
}
