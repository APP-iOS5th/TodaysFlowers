//
//  AppAppearance.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/11/24.
//

import UIKit

final class AppAppearance {
    static func configureAppearacnes() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "FlowerColor")
        UINavigationBar.appearance().backgroundColor = .white
    }
}
