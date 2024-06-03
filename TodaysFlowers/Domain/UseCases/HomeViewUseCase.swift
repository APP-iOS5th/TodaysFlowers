//
//  HomeViewUseCase.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation

protocol HomeViewUseCase {
    func getFlowers(by date: [Date]) -> [Flower]
}
