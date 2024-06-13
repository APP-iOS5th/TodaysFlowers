//
//  SearchViewController.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit
import Combine
import PhotosUI

final class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    private var searchViewModel: SearchViewModel
    private var imageDetectionViewModel: ImageDetectionViewModel
    private var cancellables = Set<AnyCancellable>()
    private let monthDayPickerView = MonthDayPickerView()
    
    private let segmentedControl = UISegmentedControl(items: ["이름", "꽃말", "날짜", "이미지"])
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        return tableView
    }()
    
    init(searchViewModel: SearchViewModel, imageDetectionViewModel: ImageDetectionViewModel) {
        self.searchViewModel = searchViewModel
        self.imageDetectionViewModel = imageDetectionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSegmentedControl()
        setupSearchController()
        setupTableView()
        monthDayPickerView.monthDayDelegate = self
        
        searchViewModel.$flowers
            .receive(on: DispatchQueue.main) // UI 업데이트를 위해 메인스레드로 전환
            .sink (receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
                self?.setNeedsUpdateContentUnavailableConfiguration()
            })
            .store(in: &cancellables)
            
        imageDetectionViewModel.$flowerName
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] flowerName in
                self?.searchViewModel.search(inputText: flowerName)
            })
            .store(in: &cancellables)
                  
      imageDetectionViewModel.$imageNotFound
          .receive(on: DispatchQueue.main) // UI 업데이트를 위해 메인스레드로 전환
          .sink (receiveValue: { [weak self] _ in
              self?.setNeedsUpdateContentUnavailableConfiguration()
          })
          .store(in: &cancellables)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.flowers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flowerCell", for: indexPath) as! SearchTableViewCell
        let flower = searchViewModel.flowers[indexPath.row]
        
        cell.configureCell(flower: flower)
        cell.selectionStyle = .none

        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(90)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {return}
        searchViewModel.search(inputText: searchBarText)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedId = searchViewModel.flowers[indexPath.row].id
        let viewModel = DetailViewModel(
            flowerId: selectedId,
            useCase: FlowersApi()
        )
        let viewController = DetailViewController(viewModel: viewModel)
        show(viewController, sender: self)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        switch searchViewModel.searchType {
        case .name, .flowerLang:
            searchBar.customInputView = nil
        case .date:
            // 인덱스 에러 이슈로 picker초기화
            monthDayPickerView.initializePicker()
            searchBar.customInputView = monthDayPickerView
        case .image:
            searchBar.resignFirstResponder() // 키보드 숨기기
            imageDetectionViewModel.imageNotFound = false
            presentPHPicker()
        }
    }
    
    // MARK: - Methods
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        // addTarget에서 변경 (iOS 14+)
        segmentedControl.addAction(UIAction { [weak self] action in
            let sender = action.sender as! UISegmentedControl
            
            // 검색 타입 바꿀때마다 테이블 및 ContentUnavailableConfiguration 초기화
            self?.searchViewModel.flowers = []
            self?.tableView.reloadData()
            self?.imageDetectionViewModel.imageNotFound = false
            
            self?.searchController.searchBar.placeholder = "검색"
            switch sender.selectedSegmentIndex {
            case 0:
                self?.searchViewModel.searchType = .name
            case 1:
                self?.searchViewModel.searchType = .flowerLang
            case 2:
                self?.searchViewModel.searchType = .date
            case 3:
                self?.searchViewModel.searchType = .image
            default:
                break
            }
        }, for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func presentPHPicker() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config: UIContentUnavailableConfiguration?
        
        if searchController.searchBar.text?.isEmpty == true {
            if searchViewModel.flowers.isEmpty {
                var emptyConfig = UIContentUnavailableConfiguration.empty()
                emptyConfig.background.backgroundColor = .systemBackground
                emptyConfig.image = UIImage(systemName: "camera.macro")?.withTintColor(UIColor(named: "FlowerColor")!, renderingMode: .alwaysOriginal)
                emptyConfig.textProperties.color = .gray
                emptyConfig.textProperties.font = UIFont.boldSystemFont(ofSize: 20)
                
                switch searchViewModel.searchType {
                case .name:
                    emptyConfig.text = "이름을 입력해주세요"
                case .flowerLang:
                    emptyConfig.text = "꽃말을 입력해주세요"
                case .date:
                    emptyConfig.text = "날짜를 선택해주세요"
                case .image:
                    if imageDetectionViewModel.imageNotFound {
                        emptyConfig.text = "선택한 꽃은 '오늘의 꽃'이 아닌 것 같아요"
                        emptyConfig.secondaryText = "다른 이미지를 선택해 주세요"
                    } else {
                        emptyConfig.text = "꽃 이미지를 선택해주세요"
                        emptyConfig.secondaryText = "선택한 꽃이 어떤 날짜의 '오늘의 꽃'인지 알려드립니다"
                    }
                }
                
                config = emptyConfig
            }
        } else {
            if searchViewModel.flowers.isEmpty {
                var searchConfig = UIContentUnavailableConfiguration.empty()
                searchConfig.background.backgroundColor = .systemBackground
                searchConfig.image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: "FlowerColor")!, renderingMode: .alwaysOriginal)
                searchConfig.text = "\(searchController.searchBar.text!)에 대한 결과가 없습니다"
                searchConfig.textProperties.color = .gray
                searchConfig.textProperties.font = UIFont.boldSystemFont(ofSize: 20)
                
                if searchViewModel.searchType == .name || searchViewModel.searchType == .flowerLang {
                    searchConfig.text = "\(searchController.searchBar.text!)에 대한 결과가 없습니다"
                    searchConfig.secondaryText = "다시 검색해 주세요"
                }
                
                config = searchConfig
            }
        }
        contentUnavailableConfiguration = config
    }
}

extension SearchViewController: MonthDayPickerViewDelegate {
    func didSelectDate(month: String, day: String) {
        searchController.searchBar.text = "\(month)월 \(day)일"
    }
}

extension SearchViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
 
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let uiImage = image as? UIImage else { return }
                
                DispatchQueue.main.async {
                    guard let coreImage = CIImage(image: uiImage) else {
                        fatalError("Failed convert to CIImage")
                    }
                    
                    self?.imageDetectionViewModel.detect(image: coreImage)
                }
            }
        }
    }
}
