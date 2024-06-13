//
//  HomeViewModel.swift
//  TodaysFlowers
//
//  Created by 황민경 on 6/10/24.
//

 import UIKit
 import Combine
 import Foundation
 
class HomeViewModel: ObservableObject {
    
    private let useCase: any HomeViewUseCase
    private var cancellables = Set<AnyCancellable>()
    init(useCase: any HomeViewUseCase) {
        self.useCase = useCase
    }
    
    @Published var flowers: [Flower] = []
    func viewDidLoad() {
        let dateArray = [
            Date.now,
            Date.retrieveDateFromToday(by: -1),
            Date.retrieveDateFromToday(by: -2),
            Date.retrieveDateFromToday(by: -3),
            Date.retrieveDateFromToday(by: -4),
        ]
        useCase
            .getFlowers(by: dateArray)
            .map { flowers in
                flowers
                    .sorted(by: {$0.date > $1.date})
                    .map { flower in
                        Flower(id: flower.id,
                               name: flower.name,
                               lang: flower.lang,
                               content: "", 
                               type: "",
                               grow: "", 
                               usage: "",
                               imageUrlString: flower.imageUrlString,
                               date: flower.date)
                    }
            }
            .assign(to: &$flowers)
    }
}
