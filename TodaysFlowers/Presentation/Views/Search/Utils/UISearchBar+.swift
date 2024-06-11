//
//  UISearchBar+.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/10/24.
//

import UIKit

extension UISearchBar {
    private var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
    
    var customInputView: UIView? {
        get {
            return textField?.inputView
        }
        set {
            textField?.inputView = newValue
            textField?.reloadInputViews()
        }
    }
}
