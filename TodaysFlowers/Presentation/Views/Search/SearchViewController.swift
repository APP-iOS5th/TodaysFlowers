//
//  SearchViewController.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit
import Combine

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModel = SearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "flowerCell")
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        viewModel.$flowers
            .receive(on: DispatchQueue.main)
            .sink (receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
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
}
