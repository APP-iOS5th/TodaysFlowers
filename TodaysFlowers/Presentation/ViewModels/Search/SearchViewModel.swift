//
//  SearchViewModel.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import Foundation
import Combine

final class SearchViewModel {
    private let useCase: any SearchUseCase
    private var searchTextPublisher = PassthroughSubject<String, Never>()
    @Published var flowers: [Flower] = []
    @Published var searchType: SearchType = .name // default는 이름으로 검색
    
    init(useCase: any SearchUseCase = SearchUseCaseStub()) {
        self.useCase = useCase
        setupSearchPublisher()
    }
    
    private func setupSearchPublisher() {
        searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // 검색 텍스트 디바운싱
            .removeDuplicates()
            .flatMap { [weak self] searchText -> AnyPublisher<[Flower], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                switch self.searchType {
                case .name:
                    return self.useCase.searchBy(name: searchText)
                case .flowerLang:
                    return self.useCase.searchBy(flowerLang: searchText)
                case .image:
                    return self.useCase.searchBy(name: searchText)
                }
            }
            .assign(to: &$flowers) // Combine의 re-publish 기능
    }
    
    func search(inputText: String) {
        searchTextPublisher.send(inputText)
    }
}

