//
//  ArticleListTableViewCell.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit
import SDWebImage

class ArticleListTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    
    // MARK: Properties
    var viewModel: ArticleListCellViewModelType! {
        didSet {
            setupData()
        }
    }
    
    // MARK: View Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAppearance()
    }
    
}

// MARK: - Helper Methods
private extension ArticleListTableViewCell {
    
    func setupViewsAppearance() {
        outerView.setCornerRadius(10)
        articleImageView.setCornerRadius(5, andClipContent: true)
    }
    
    func setupData() {
        articleTitleLabel.text = viewModel.articleTitle
        authorNameLabel.text = viewModel.authorNameText
        articleDateLabel.text = viewModel.publishedDate
        articleImageView.sd_setImage(with: viewModel.articleImageURL, placeholderImage: .placeholderImage)
    }
}
