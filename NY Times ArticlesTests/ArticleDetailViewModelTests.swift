//
//  ArticleDetailViewModelTests.swift
//  NY Times ArticlesTests
//
//  Created by Najeeb on 01/11/2022.
//

import XCTest
@testable import NY_Times_Articles

class ArticleDetailViewModelTests: XCTestCase {
    
    var media = Media(type: "image", metadata: [MediaMetadata(url: URL(string: "www.articleimage.com"), format: nil, height: nil, width: nil)])

    var sampleArticle: Article {
        Article(articleUrl: "www.article1.com", title: "Title1", authorName: "By Author1",
                                publishedDate: DateComponents(calendar: .current, year: 2022, month: 10, day: 28).date! ,
                                section: "Category1", media: [media], summary: "Summary of the 1st article")
    }
    
    
    var articleDetailViewModel: (Article, ArticleDetailCoordinatorType) -> ArticleDetailViewModel = { (article, coordinator) in
        ArticleDetailViewModel(article: article, coordinator: coordinator)
    }
    
    
    func test_articleDetails() {
        let sut = articleDetailViewModel(sampleArticle, MockedArticleDetailCoordinator())
        
        XCTAssertEqual(sut.articleTitle, "Title1")
        
        XCTAssertEqual(sut.articleCategory, "Category1")
        
        XCTAssertEqual(sut.articleSummary, "Summary of the 1st article")
        
        XCTAssertEqual(sut.authorNameText, "By Author1")
        
        XCTAssertEqual(sut.publishedDate, "Oct 28, 2022")
        
        XCTAssertEqual(sut.articleImageURL?.absoluteString, "www.articleimage.com")
    }
    
    func test_openFullArticle() {
        let coordinator = MockedArticleDetailCoordinator()
        let sut = articleDetailViewModel(sampleArticle, coordinator)
        
        XCTAssertNil(coordinator.articleURL)
        
        sut.openFullArticle()
        
        XCTAssertNotNil(coordinator.articleURL)
        
        XCTAssertEqual(coordinator.articleURL?.absoluteString, "www.article1.com")
    }
}



// Mocked Types
class MockedArticleDetailCoordinator: ArticleDetailCoordinatorType {
    
    var articleURL: URL?
    
    func openArticleURL(_ url: URL) {
        articleURL = url
    }
    
}
