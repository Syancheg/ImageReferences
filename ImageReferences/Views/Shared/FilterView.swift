//
//  FilterView.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 09.05.2022.
//

import UIKit

class FilterView: UIView {
    
    var filterGroupId: Int = 0
    var filters: [Filter] = [Filter(id: 0, name: "Не выбрано")]
    var delegate: MainOutputDelegate?
    
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
        setupView()
    }
    
    func setupView() {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 100))
        picker.delegate = self
        picker.dataSource = self
        self.addSubview(picker)
    }
    
}

extension FilterView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let delegate = self.delegate else { return }
        delegate.setFilter(with: [filterGroupId:filters[row].id])
    }
    
    
}
