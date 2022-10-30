//
//  ArticleCoordinator.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import UIKit
import SafariServices


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class ArticleCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let articlesList = makeArticlesListViewController()
        navigationController.pushViewController(articlesList, animated: true)
    }
    
}

private extension ArticleCoordinator {
    
    func makeArticlesListViewController() -> UIViewController {
        let config = APIConfiguration(baseURL: Utils.baseUrl, apiKey: Utils.apiKey)
        let client = WebClient(config: config)
        let service = ArticleService(config: config, apiClient: client)
        let viewModel = ArticlesListViewModel(service: service, coordinator: self)
        let viewController = ArticlesListViewController.instantiate(from: .Main) { coder in
            return ArticlesListViewController(coder: coder, viewModel: viewModel)!
        }
        return viewController
    }
    
    func makeArticleDetailViewController(_ article: Article) -> UIViewController {
        let viewModel = ArticleDetailViewModel(article: article, coordinator: self)
        let viewController = ArticleDetailViewController.instantiate(from: .Main) { coder in
            return ArticleDetailViewController(coder: coder, viewModel: viewModel)!
        }
        return viewController
    }
    
}

extension ArticleCoordinator: ArticlesListCoordinatorType {
    
    func naviagteToArticle(_ article: Article) {
        let detailController = makeArticleDetailViewController(article)
        navigationController.pushViewController(detailController, animated: true)
    }
    
}


extension ArticleCoordinator: ArticleDetailCoordinatorType {
    
    func openArticleURL(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController.present(safariVC, animated: true)
    }
    
}
