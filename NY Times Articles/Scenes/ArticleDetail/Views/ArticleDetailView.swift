//
//  ArticleDetailView.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import UIKit

class ArticleDetailView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sectionOuterView: UIView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleSummaryLabel: UILabel!
    @IBOutlet weak var readFullArticleButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupViewsAppearance()
    }
    
}


private extension ArticleDetailView {
    
    func setupViewsAppearance() {
        sectionOuterView.setCornerRadius(5)
        readFullArticleButton.setCornerRadius(10)
    }
}
