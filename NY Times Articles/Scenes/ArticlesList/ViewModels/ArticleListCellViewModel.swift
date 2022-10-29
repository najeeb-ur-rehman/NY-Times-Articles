//
//  ArticleListCellViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import Foundation

protocol ArticleListCellViewModelType {
    var articleTitle: String { get }
    var authorNameText: String { get }
    var publishedDate: String { get }
    var articleImageURL: URL? { get }
}

class ArticleListCellViewModel: ArticleListCellViewModelType {
    
    var articleTitle: String {
        article.title
    }
    
    var authorNameText: String {
        article.authorName
    }
    
    var publishedDate: String {
        article.publishedDate
    }
    
    var articleImageURL: URL? {
        article.media?.first?.articlePosterURL ?? nil
    }
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
}
