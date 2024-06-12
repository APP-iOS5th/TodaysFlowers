//
//  DetailViewUseCaseStub.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation
import Combine

final class DetailViewUseCaseStub: DetailViewUseCase {
    func getFlower(by id: Int) -> AnyPublisher<Flower, Never> {
        Just(FlowerStubs.flowers.first { $0.id == id })
            .compactMap { $0 }
            .delay(for: .seconds(0.5), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
