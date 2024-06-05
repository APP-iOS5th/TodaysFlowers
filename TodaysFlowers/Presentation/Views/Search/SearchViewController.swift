//
//  SearchViewController.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit
import Combine

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    private var viewModel = SearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "flowerCell")
        
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let segmentedControl = UISegmentedControl(items: ["이름", "꽃말"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setupSearchController()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        
        viewModel.$flowers
            .receive(on: DispatchQueue.main)
            .sink (receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func setupTableView() {
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
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "이름 검색"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchController.searchBar.placeholder = "이름 검색"
            viewModel.searchType = .name
        case 1:
            searchController.searchBar.placeholder = "꽃말 검색"
            viewModel.searchType = .flowerLang
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.flowers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flowerCell", for: indexPath) as! SearchTableViewCell
        let flower = self.viewModel.flowers[indexPath.row]
        
        cell.configureCell(flower: flower)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(90)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {return}
        viewModel.search(inputText: searchBarText)
    }
}
