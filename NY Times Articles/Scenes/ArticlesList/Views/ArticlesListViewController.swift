//
//  ArticlesListViewController.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var articlesListView: ArticlesListView!
    
    // MARK: Properties
    var viewModel: ArticlesListViewModelType
    
    
    // MARK: Initializers
    init?(coder: NSCoder, viewModel: ArticlesListViewModelType) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to initialize an `ArticlesListViewController` instance.")
    }

    
    // MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Popular Articles"
        navigationItem.backButtonTitle = " "
        
        setupTableView()
        setupBindings()
        viewModel.fetchPopularArtciles()
    }
    
}


// MARK: - Helper Methods
private extension ArticlesListViewController {
    
    func setupBindings() {
        viewModel.fetchingData = { [weak self] isFetching in
            self?.showLoader(isFetching)
        }
        viewModel.onDataAvailable = { [weak self] in
            self?.handleDataUpdate()
        }
        viewModel.onError = { [weak self] message in
            self?.showErrorMessage(message)
        }
    }
    
    func showErrorMessage(_ message: String) {
        Utils.showOkAlert(message: message, viewController: self)
    }
    
    func handleDataUpdate() {
        articlesListView.tableview.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        show ? LoadingView.show(self.view) :LoadingView.hide(self.view)
    }
    
    func setupTableView() {
        articlesListView.tableview.dataSource = self
        articlesListView.tableview.delegate = self
    }
    
}

// MARK: - UITableViewDataSource Methods
extension ArticlesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleListTableViewCell.reuseIdentifier,
            for: indexPath) as! ArticleListTableViewCell
        if let article = viewModel.articleAtIndex(indexPath.row) {
            cell.viewModel = ArticleListCellViewModel(article: article)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalArticles
    }
    
}

// MARK: - UITableViewDelegate Methods
extension ArticlesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showArticleDetailsAtIndex(indexPath.row)
    }
}
