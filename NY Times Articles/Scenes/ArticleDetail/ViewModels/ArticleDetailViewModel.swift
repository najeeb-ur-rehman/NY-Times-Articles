//
//  ArticleDetailViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 30/10/2022.
//

import Foundation

protocol ArticleDetailViewModelType {
    var articleTitle: String { get }
    var authorNameText: String { get }
    var publishedDate: String { get }
    var articleImageURL: URL? { get }
    var articleCategory: String { get }
    var articleSummary: String { get }
    func openFullArticle()
}

protocol ArticleDetailCoordinatorType {
    func openArticleURL(_ url: URL)
}

class ArticleDetailViewModel: ArticleDetailViewModelType {
    
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
        article.section ?? " - "
    }
    
    var articleSummary: String {
        article.summary
    }
    
    private let article: Article
    private let coordinator: ArticleDetailCoordinatorType
    
    init(article: Article, coordinator: ArticleDetailCoordinatorType) {
        self.article = article
        self.coordinator = coordinator
    }
    
    func openFullArticle() {
        guard let url = URL(string: article.articleUrl ?? "") else {
            return
        }
        coordinator.openArticleURL(url)
    }
    
}
