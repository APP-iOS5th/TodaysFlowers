//
//  SearchUseCaseStub.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation
import Combine

final class SearchUseCaseStub: SearchUseCase {
    func searchBy(month: String, day: String) -> AnyPublisher<[Flower], Never> {
        Just(FlowerStubs.flowers)
            .eraseToAnyPublisher()
    }
    
    func searchBy(name: String) -> AnyPublisher<[Flower], Never> {
        Just(FlowerStubs.flowers)
            .map { flowers in
                flowers.filter { $0.name.contains(name) }
            }
            .eraseToAnyPublisher()
    }
    
    func searchBy(flowerLang: String) -> AnyPublisher<[Flower], Never> {
        Just(FlowerStubs.flowers)
            .map { flowers in
                flowers.filter { $0.lang.contains(flowerLang) }
            }
            .eraseToAnyPublisher()
    }
}
