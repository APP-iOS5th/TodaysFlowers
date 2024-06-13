//
//  RootTabBarController.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/11/24.
//

import UIKit

final class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    private func start() {
        let pages: [TabBarPage] = TabBarPage.allCases
        let viewControllers = pages.map(configureTabController(_:))
        
        prepareTabBarController(with: viewControllers)
    }
    
    private func prepareTabBarController(
        with viewControllers: [UIViewController]
    ) {
        setViewControllers(viewControllers, animated: false)
        selectedIndex = TabBarPage.home.pageOrderNumber
    }
    
    private func configureTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = {
            switch page {
            case .home:
                let homeViewController = HomeViewController(
                    viewModel: HomeViewModel(useCase: FlowersApi())
                )
                return UINavigationController(rootViewController: homeViewController)
            case .search:
                let searchViewController = SearchViewController(
                    searchViewModel: SearchViewModel(useCase: FlowersApi()),
                    imageDetectionViewModel: ImageDetectionViewModel()
                )
                return UINavigationController(rootViewController: searchViewController)
            }
        }()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem(
            title: page.pageTitle,
            image: UIImage(systemName: page.pageIconString),
            tag: page.pageOrderNumber
        )

        return navController
    }
}

private extension RootTabBarController {
    enum TabBarPage: String, CaseIterable {
        case home
        case search
        
        var pageTitle: String {
            rawValue.capitalized
        }
        
        var pageOrderNumber: Int {
            switch self {
                case .home:
                    return 0
                case .search:
                    return 1
            }
        }
        
        var pageIconString: String {
            switch self {
                case .home:
                    return "house"
                case .search:
                    return "magnifyingglass"
            }
        }
    }
}
