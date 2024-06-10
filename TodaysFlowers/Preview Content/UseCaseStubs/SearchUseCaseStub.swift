//
//  SearchUseCaseStub.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation
import Combine

final class SearchUseCaseStub: SearchUseCase {
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
    
    func searchBy(date: String) -> AnyPublisher<[Flower], Never> {
        let components = date.split { !$0.isNumber }
        let month = components.first.map { String($0) }
        let day = components.last.map { String($0) }
        
        return Just(FlowerStubs.flowers)
            .map { flowers in
                guard let month = month, let day = day else {
                    return []
                }
//                return flowers.filter { $0.fMonth == month && $0.fDay == day }
                return []
            }
            .eraseToAnyPublisher()
    }
}
