//
//  ArticleDetailViewController.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var articleDetailView: ArticleDetailView!
    
    
    // MARK: Properties
    var viewModel: ArticleDetailViewModelType
    
    
    // MARK: Initializers
    init?(coder: NSCoder, viewModel: ArticleDetailViewModelType) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to initialize an `ArticleDetailViewController` instance.")
    }

    // MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(named: "TitleColor")
        setupData()
    }
    
    // MARK: Actions
    @IBAction
    func readFullArticleButtonAction(_ sender: UIButton) {
        viewModel.openFullArticle()
    }
}

// MARK: - Helper Methods
private extension ArticleDetailViewController {
    
    func setupData() {
        articleDetailView.articleTitleLabel.text = viewModel.articleTitle
        articleDetailView.dateLabel.text = viewModel.publishedDate
        articleDetailView.authorNameLabel.text = viewModel.authorNameText
        articleDetailView.articleSummaryLabel.text = viewModel.articleSummary
        articleDetailView.categoryLabel.text = viewModel.articleCategory
        articleDetailView.articleImageView.sd_setImage(with: viewModel.articleImageURL,
                                                       placeholderImage: .placeholderImage)
    }
    
}
