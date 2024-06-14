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
            .map { flower in
                let replacedContent = StringHandler.separateByComma(flower.content)
                let replacedType = StringHandler.separateByComma(flower.type)
                let replacedGrow = StringHandler.separateByComma(flower.grow)
                let replacedUsage = StringHandler.separateByComma(flower.usage)
                
                return Flower(
                    id: flower.id,
                    name: flower.name,
                    lang: flower.lang,
                    content: replacedContent,
                    type: replacedType,
                    grow: replacedGrow,
                    usage: replacedUsage,
                    imageUrlString: flower.imageUrlString,
                    date: flower.date
                )
            }
            .assign(to: &$flower)
    }
}

extension Flower {
    static var placeholder: Flower {
        .init(id: 0, name: "", lang: "", content: "", type: "", grow: "", usage: "", imageUrlString: [], date: Date.now)
    }
}
