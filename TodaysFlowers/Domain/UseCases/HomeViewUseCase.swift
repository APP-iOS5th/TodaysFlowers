//
//  HomeViewUseCase.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation
import Combine

protocol HomeViewUseCase {
    func getFlowers(by date: [Date]) -> AnyPublisher<[Flower], Never>
    func retrieveFlower(by date: Date) -> AnyPublisher<Flower, Never>
}
