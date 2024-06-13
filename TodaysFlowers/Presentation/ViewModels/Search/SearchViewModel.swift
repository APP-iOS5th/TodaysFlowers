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
    
    init(useCase: any SearchUseCase = FlowersApi()) {
        self.useCase = useCase
        setupSearchPublisher()
    }
    
    private func setupSearchPublisher() {
        searchTextPublisher
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main) // 검색 텍스트 디바운싱
            .removeDuplicates()
            .flatMap { [weak self] searchText -> AnyPublisher<[Flower], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                
                if searchText.isEmpty {
                    return Just([]).eraseToAnyPublisher()
                }
                
                switch self.searchType {
                case .name:
                    return self.useCase.searchBy(name: searchText)
                case .flowerLang:
                    return self.useCase.searchBy(flowerLang: searchText)
                case .date:
                    // n월 n일 형식으로 들어오는 searchText를 분리
                    let dateArray = searchText.split { !$0.isNumber }
                    guard dateArray.count == 2,
                          let month = dateArray.first.map({ String($0) }),
                          let day = dateArray.last.map({ String($0) }) else {
                        fatalError("잘못된 날짜 포멧입니다.")
                    }
                    
                    return self.useCase.searchBy(month: month, day: day)
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

