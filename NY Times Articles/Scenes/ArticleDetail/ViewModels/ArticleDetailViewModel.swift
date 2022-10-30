//
//  ArticleDetailViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import Foundation

class ArticleDetailViewModel {
    
    var articleTitle: String {
        article.title
    }
    
    var authorNameText: String {
        article.authorName
    }
    
    var publishedDate: String {
        article.publishedDate.formatted(date: .abbreviated, time: .omitted)
    }
    
    var articleImageURL: URL? {
        article.media?.first?.articlePosterURL ?? nil
    }
    
    var articleCategory: String {
        article.section ?? ""
    }
    
    var articleSummary: String {
        article.summary
    }
    
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
}
