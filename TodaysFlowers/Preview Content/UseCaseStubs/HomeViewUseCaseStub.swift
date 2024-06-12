//
//  HomeViewUseCaseStub.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation
import Combine

final class HomeViewUseCaseStub: HomeViewUseCase {
    func retrieveFlower(by date: Date) -> AnyPublisher<Flower, Never> {
        Just(FlowerStubs.flower)
            .eraseToAnyPublisher()
    }
    
    func getFlowers(by date: [Date]) -> AnyPublisher<[Flower], Never> {
        Just(FlowerStubs.flowers)
            .eraseToAnyPublisher()
    }
}
