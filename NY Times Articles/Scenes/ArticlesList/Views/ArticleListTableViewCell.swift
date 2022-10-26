//
//  ArticleListTableViewCell.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAppearance()
    }
    
    private func setupViewsAppearance() {
        outerView.setCornerRadius(10)
        
        articleImageView.setCornerRadius(5, andClipContent: true)
    }

}
