//
//  ArticlesListViewModel.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import Foundation

protocol ArticlesListViewModelType {
    var isLoading: Bool { get }
    var dataAvailable: Bool { get }
    var errorMessage: String? { get }
    var totalArticles: Int { get }
    func articleAtPosition(_ position: Int) -> Article?
    func fetchPopularArtciles()
}

class ArticlesListViewModel: ArticlesListViewModelType {
    
    @Published private(set) var isLoading = false
    @Published private(set) var dataAvailable = false
    @Published private(set) var errorMessage: String?
    
    var totalArticles: Int {
        articles.count
    }
    
    
    private(set) var articles = [Article]()
    private let articleService: ArticleServiceType
    
    
    init(service: ArticleServiceType) {
        self.articleService = service
    }
    
    
    func articleAtPosition(_ position: Int) -> Article? {
        if position < articles.count {
            return articles[position]
        }
        return nil
    }
    
    func fetchPopularArtciles() {
        isLoading = true
        articleService.getArticles { [weak self] (result: Result<ArticlesResponse, NetworkErrors>) in
            guard let self = self else {
                return
            }
            self.isLoading = false
            switch result {
            case .success(let articleResponse):
                if let articles = articleResponse.results, articles.count > 0 {
                    self.dataAvailable = true
                    self.articles = articles
                } else {
                    self.errorMessage = "No article found"
                }
            case .failure(let error):
                self.errorMessage = error.errorDescription
            }
        }
    }
}
