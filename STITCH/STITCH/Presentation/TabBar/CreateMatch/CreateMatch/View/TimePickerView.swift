//
//  TimePickerView.swift
//  STITCH
//
//  Created by neuli on 2023/03/07.
//

import UIKit

enum Meridiem: String, CaseIterable {
    case am = "오전", pm = "오후"
}

enum Minute: Int, CaseIterable {
    case zero = 0, ten = 10, twenty = 20, thirty = 30, fourty = 40, fifty = 50
}

enum Hour: Int, CaseIterable {
    case one = 1, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
}

final class TimePickerView: UIPickerView {
    
    // MARK: - Initializer
    
    init(viewController: UIPickerViewDelegate) {
        super.init(frame: .zero)
        delegate = viewController
        dataSource = self
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .gray12.withAlphaComponent(0.8)
    }
}

extension TimePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return Meridiem.allCases.count
        } else if component == 1 {
            return Hour.allCases.count
        } else {
            return Minute.allCases.count
        }
    }
}
