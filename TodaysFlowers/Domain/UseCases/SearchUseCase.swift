//
//  SearchUseCase.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation
import Combine

protocol SearchUseCase {
    func searchBy(name: String) -> AnyPublisher<[Flower], Never>
    func searchBy(flowerLang: String) -> AnyPublisher<[Flower], Never>
    func searchBy(month: String, day: String) -> AnyPublisher<[Flower], Never>
}
