//
//  DetailViewModel.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation
import Combine

final class DetailViewModel {
    private let flowerId: Int
    private let useCase: DetailViewUseCase
    
    @Published private(set) var flower: Flower = Flower.placeholder
    
    init(flowerId: Int, useCase: DetailViewUseCase) {
        self.flowerId = flowerId
        self.useCase = useCase
    }
    
    func fetchFlower() {
        useCase
            .getFlower(by: flowerId)
            .assign(to: &$flower)
    }
}

extension Flower {
    static var placeholder: Flower {
        .init(id: 0, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageData: [], date: Date.now)
    }
}
