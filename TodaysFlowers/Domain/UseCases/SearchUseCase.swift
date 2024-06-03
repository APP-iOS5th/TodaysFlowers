//
//  SearchUseCase.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation

protocol SearchUseCase {
    func searchBy(name: String) -> [Flower]
    func searchBy(flowerLang: String) -> [Flower]
}
