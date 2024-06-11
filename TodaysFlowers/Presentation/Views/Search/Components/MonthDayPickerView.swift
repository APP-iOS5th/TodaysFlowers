//
//  MonthDayPickerView.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/5/24.
//

import UIKit

protocol MonthDayPickerViewDelegate: NSObject {
    func didSelectDate(month: String, day: String)
}

final class MonthDayPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var months = Array(1...12).map { String($0) }
    let daysInMonth: [String: [String]] = [
        "1": Array(1...31).map { String($0) },
        "2": Array(1...29).map { String($0) },
        "3": Array(1...31).map { String($0) },
        "4": Array(1...30).map { String($0) },
        "5": Array(1...31).map { String($0) },
        "6": Array(1...30).map { String($0) },
        "7": Array(1...31).map { String($0) },
        "8": Array(1...31).map { String($0) },
        "9": Array(1...30).map { String($0) },
        "10": Array(1...31).map { String($0) },
        "11": Array(1...30).map { String($0) },
        "12": Array(1...31).map { String($0) }
    ]
    
    weak var monthDayDelegate: MonthDayPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            let selectedMonthIdx = pickerView.selectedRow(inComponent: 0)
            let month = months[selectedMonthIdx]
            
            return daysInMonth[month]?.count ?? 0
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(months[row])월"
        case 1:
            let selectedMonthIdx = pickerView.selectedRow(inComponent: 0)
            let month = months[selectedMonthIdx]
            
            return "\(daysInMonth[month]?[row] ?? "")일"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let selectedMonthIdx = pickerView.selectedRow(inComponent: 0)
            let selectedDayIdx = pickerView.selectedRow(inComponent: 1)
            
            let month = self.months[selectedMonthIdx]
            let day = self.daysInMonth[month]?[selectedDayIdx] ?? ""
            
            self.monthDayDelegate?.didSelectDate(month: month, day: day)
        }
    }
}
