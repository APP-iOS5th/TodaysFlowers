//
//  DetailViewUseCase.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation
import Combine

protocol DetailViewUseCase {
    func getFlower(by id: Int) -> AnyPublisher<Flower, Never>
}
