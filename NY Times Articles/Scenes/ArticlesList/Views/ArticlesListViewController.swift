//
//  ArticlesListViewController.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit
import Combine

class ArticlesListViewController: UIViewController {
    
    @IBOutlet var articlesListView: ArticlesListView!
    
    var viewModel: ArticlesListViewModel
    
    private var subscribers = Set<AnyCancellable>()
    
    
    // MARK: Initializers
    
    init?(coder: NSCoder, viewModel: ArticlesListViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to initialize an `ArticlesListViewController` instance.")
    }

    
    // MARK: ViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesListView.tableview.dataSource = self
        articlesListView.tableview.delegate = self
        setupBindings()
        viewModel.fetchPopularArtciles()
    }
    
}


// MARK: Helper Methods
private extension ArticlesListViewController {
    
    func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: showLoader(_:))
            .store(in: &subscribers)
        
        viewModel.$dataAvailable
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in self.reloadTableViewData() })
            .store(in: &subscribers)
        
        viewModel.$errorMessage
            .compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: showErrorMessage(_:))
            .store(in: &subscribers)
                    
    }
    
    func showErrorMessage(_ message: String) {
        Utils.showOkAlert(message: message, viewController: self)
    }
    
    func reloadTableViewData() {
        articlesListView.tableview.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        show ? LoadingView.show(self.view) :LoadingView.hide(self.view)
    }
    
}

extension ArticlesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! ArticleListTableViewCell
        if let article = viewModel.articleAtPosition(indexPath.row) {
            cell.viewModel = ArticleListCellViewModel(article: article)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalArticles
    }
    
}


extension ArticlesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let art = viewModel.articleAtPosition(indexPath.row) else {
            return
        }
        let ctrl = AppContainer.makeArticleDetailViewController(art)
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
}
