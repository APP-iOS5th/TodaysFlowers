//
//  HomeViewController.swift
//  TodaysFlowers
//
//  Created by 황민경 on 6/10/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    private var viewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 250) // 셀 크기 조정
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    // dateLabel 날짜
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        let formatter = DateFormatter()
        //formatter.dateStyle = .long
        formatter.dateFormat = "MMM d"
        dateLabel.text = formatter.string(from: Date())
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight:  .semibold)
        return dateLabel
    }()
    // titleLabel 앱 제목
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "오늘의 꽃"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = UIColor(named: "FlowerColor")
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        collectionView.delegate = self
    }
    // UI 레이아웃 설정
    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(dateLabel)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: "FlowerCell")
        collectionView.dataSource = self

    }

    private func bindViewModel() {
        viewModel.$flowers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flowers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlowerCell", for: indexPath) as? HomeViewCell else {
            return UICollectionViewCell()
        }
        let flower = viewModel.flowers[indexPath.item]
        cell.configure(with: flower)
        return cell
    }
}

// 셀 클릭했을 때 콘솔창에 "선택" 메시지 출력 (셀 선택 효과 추가하니까 안됨 수정 필요))
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("선택")
    }
}
