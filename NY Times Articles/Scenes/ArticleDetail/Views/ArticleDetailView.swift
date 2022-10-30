//
//  ArticleDetailView.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import UIKit

class ArticleDetailView: UIView {

    // MARK: Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryOuterView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleSummaryLabel: UILabel!
    @IBOutlet weak var readFullArticleButton: UIButton!

    // MARK: View Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()

        setupViewsAppearance()
    }
    
}

// MARK: - Helper Methods
private extension ArticleDetailView {
    
    func setupViewsAppearance() {
        categoryOuterView.setCornerRadius(5)
        readFullArticleButton.setCornerRadius(10)
    }
}
