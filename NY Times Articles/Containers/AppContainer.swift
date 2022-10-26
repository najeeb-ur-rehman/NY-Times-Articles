//
//  AppContainer.swift
//  NY Times Articles
//
//  Created by Najeeb on 26/10/2022.
//

import UIKit

class AppContainer {
    
    static func makeArticleListViewController() -> UIViewController {
        let viewModel = ArticlesListViewModel()
        let viewController = ArticlesListViewController.instantiate(from: .Main) { coder in
            return ArticlesListViewController(coder: coder, viewModel: viewModel)!
        }
        return viewController
    }
}
