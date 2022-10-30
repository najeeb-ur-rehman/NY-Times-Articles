//
//  ArticleDetailViewController.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    
    @IBOutlet var articleDetailView: ArticleDetailView!
    
    var viewModel: ArticleDetailViewModel
    
    // MARK: Initializers
    
    init?(coder: NSCoder, viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to initialize an `ArticlesListViewController` instance.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(named: "TitleColor")
        setupBindings()
    }
    
    func setupBindings() {
        articleDetailView.articleTitleLabel.text = viewModel.articleTitle
        articleDetailView.dateLabel.text = viewModel.publishedDate
        articleDetailView.authorNameLabel.text = viewModel.authorNameText
        articleDetailView.articleSummaryLabel.text = viewModel.articleSummary
        articleDetailView.sectionLabel.text = viewModel.articleCategory
        articleDetailView.articleImageView.sd_setImage(with: viewModel.articleImageURL, placeholderImage: .placeholderImage)
    }
    
}

