//
//  AppContainer.swift
//  NY Times Articles
//
//  Created by Najeeb on 26/10/2022.
//

import UIKit

class AppContainer {
    
    static func makeArticleListViewController() -> UIViewController {
        let config = getAPIConfiguration()
        let client = WebClient(config: config)
        let service = ArticleService(config: config, apiClient: client)
        let viewModel = ArticlesListViewModel(service: service)
        let viewController = ArticlesListViewController.instantiate(from: .Main) { coder in
            return ArticlesListViewController(coder: coder, viewModel: viewModel)!
        }
        viewController.navigationItem.title = "Popular Articles"
        viewController.navigationItem.backButtonTitle = " "
        return viewController
    }
    
    static func getAPIConfiguration() -> APIConfiguration{
        let config = APIConfiguration(baseURL: URL(string: "https://api.nytimes.com")!, apiKey: "jABQK7KhauIOLisCnlYjh1uBqGMgUXAA")
        return config
    }
    
    static func makeArticleDetailViewController(_ article: Article) -> UIViewController {
        let viewModel = ArticleDetailViewModel(article: article)
        let viewController = ArticleDetailViewController.instantiate(from: .Main) { coder in
            return ArticleDetailViewController(coder: coder, viewModel: viewModel)!
        }
        return viewController
    }
}
