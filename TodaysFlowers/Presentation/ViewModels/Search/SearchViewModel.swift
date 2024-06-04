//
//  SearchViewModel.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import Foundation
import Combine

class SearchViewModel {
    private let useCase: any SearchUseCase
    @Published var flowers: [Flower] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: any SearchUseCase = SearchUseCaseStub()) {
        self.useCase = useCase
    }
    
    func search(inputText: String) {
        useCase.searchBy(name: inputText)
            .sink(receiveValue: { [weak self] flowers in
                self?.flowers = flowers
            })
            .store(in: &cancellables)
    }
}
