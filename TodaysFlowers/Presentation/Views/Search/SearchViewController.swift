//
//  SearchViewController.swift
//  TodaysFlowers
//
//  Created by 이인호 on 6/4/24.
//

import UIKit

class SearchViewController: UIViewController {

    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func clickButton() {
        viewModel.search(inputText: "아잘레아")
    }
    
}
