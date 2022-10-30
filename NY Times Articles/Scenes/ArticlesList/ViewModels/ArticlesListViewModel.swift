//
//  ArticlesListViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import Foundation

protocol ArticlesListViewModelType {
    var fetchingData: ((Bool) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onDataAvailable: (() -> Void)? { get set }
    var totalArticles: Int { get }
    func showArticleDetailsAtIndex(_ index: Int)
    func fetchPopularArtciles()
    func articleAtIndex(_ index: Int) -> Article?
}

protocol ArticlesListCoordinatorType {
    func naviagteToArticle(_ article: Article)
}

class ArticlesListViewModel: ArticlesListViewModelType {
    
    var fetchingData: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onDataAvailable: (() -> Void)?
    
    var totalArticles: Int {
        articles.count
    }
    
    
    private(set) var articles = [Article]()
    private let articleService: ArticleServiceType
    private let coordinator: ArticlesListCoordinatorType
    
    
    init(service: ArticleServiceType, coordinator: ArticlesListCoordinatorType) {
        self.articleService = service
        self.coordinator = coordinator
    }
    
    func articleAtIndex(_ index: Int) -> Article? {
        if index < articles.count {
            return articles[index]
        }
        return nil
    }
    
    func showArticleDetailsAtIndex(_ index: Int) {
        guard let article = articleAtIndex(index) else {
            onError?("Article not found")
            return
        }
        coordinator.naviagteToArticle(article)
    }
    
    func fetchPopularArtciles() {
        fetchingData?(true)
        articleService.getArticles { [weak self] (result: Result<ArticlesResponse, NetworkErrors>) in
            guard let self = self else {
                return
            }
            self.fetchingData?(false)
            switch result {
            case .success(let articleResponse):
                if let articles = articleResponse.results, articles.count > 0 {
                    self.articles = articles
                    self.onDataAvailable?()
                } else {
                    self.onError?("No article found")
                }
            case .failure(let error):
                self.onError?(error.errorDescription ?? "Error occured")
            }
        }
    }
}
