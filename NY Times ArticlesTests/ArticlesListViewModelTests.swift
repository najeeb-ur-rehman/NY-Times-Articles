//
//  ArticlesListViewModelTests.swift
//  NY Times ArticlesTests
//
//  Created by Najeeb on 31/10/2022.
//

import XCTest
@testable import NY_Times_Articles

class ArticlesListViewModelTests: XCTestCase {

    var mockedService: MockedArticleService {
        MockedArticleService()
    }
    
    var mockedCoordinator: MockedArticlesCoordinator {
        MockedArticlesCoordinator()
    }
    
    var articleViewModel: (MockedArticleService, MockedArticlesCoordinator) -> ArticlesListViewModel = { (service, coordinator) in
        ArticlesListViewModel(service: service, coordinator: coordinator)
    }
    
    func test_fetchPopularArticle_success() {
        let service = mockedService
        service.wait = 2
        let sut = articleViewModel(service, mockedCoordinator)
        var showLoading = false
        var hideLoading = false
        var errorOccured = false
        
        let expectation = self.expectation(description: "Waiting for the articles service to complete")
        
        sut.fetchingData = { isFetching in
            if isFetching {
                showLoading = true
            } else {
                hideLoading = true
            }
        }
        
        sut.onError = { _ in
            errorOccured = true
        }
        
        sut.onDataAvailable = {
            expectation.fulfill()
        }
        
        sut.fetchPopularArtciles()
        
        XCTAssertTrue(showLoading)
        
        waitForExpectations(timeout: TimeInterval(service.wait + 1)) { error in
            XCTAssertNil(error)
            
            XCTAssertFalse(errorOccured)
            
            XCTAssertTrue(hideLoading)
            
            XCTAssertTrue(sut.totalArticles > 0)
        }
    }
    
    func test_fetchPopularArticle_failure() {
        let service = mockedService
        service.simulateError = true
        let sut = articleViewModel(service, mockedCoordinator)
        var showLoading = false
        var hideLoading = false
        var dataAvailable = false
        
        let expectation = self.expectation(description: "Waiting for the articles service to complete")
        
        sut.fetchingData = { isFetching in
            if isFetching {
                showLoading = true
            } else {
                hideLoading = true
            }
        }
        
        sut.onError = { _ in
            expectation.fulfill()
        }
        
        sut.onDataAvailable = {
            dataAvailable = true
        }
        
        
        sut.fetchPopularArtciles()
        
        XCTAssertTrue(showLoading)
        
        waitForExpectations(timeout: TimeInterval(mockedService.wait + 1)) { error in
            XCTAssertNil(error)
            
            XCTAssertFalse(dataAvailable)
            
            XCTAssertTrue(hideLoading)
            
            XCTAssertTrue(sut.totalArticles == 0)
        }
    }
    
    func test_articleAtIndex() {
        let sut = articleViewModel(mockedService, mockedCoordinator)
        
        let expectation = self.expectation(description: "Waiting for the articles service to complete")
        
        sut.fetchPopularArtciles()
        
        sut.onDataAvailable = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error)
            
            XCTAssertTrue(sut.totalArticles == 2)
            
            XCTAssertNil(sut.articleAtIndex(-1))
            
            XCTAssertNil(sut.articleAtIndex(2))
            
            XCTAssertNotNil(sut.articleAtIndex(1))
        }
    }
    
    func test_showArticleDetail() {
        let service = mockedService
        let coordinator = mockedCoordinator
        let sut = articleViewModel(service, coordinator)
        
        let expectation = self.expectation(description: "Waiting for the articles service to complete")
        
        sut.fetchPopularArtciles()
        
        sut.onDataAvailable = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: TimeInterval(service.wait + 1)) { error in
            XCTAssertNil(error)
            
            XCTAssertTrue(sut.totalArticles == 2)
            
            sut.showArticleDetailsAtIndex(-1)
            
            XCTAssertNil(coordinator.articleToNavigate)
            
            sut.showArticleDetailsAtIndex(0)
            
            XCTAssertNotNil(coordinator.articleToNavigate)
            
            XCTAssertEqual(coordinator.articleToNavigate?.title, "Title1")
        }
    }

}


// Mocked Types
class MockedArticleService: ArticleServiceType {
    
    var simulateError = false
    var wait = 0
    
    var sampleArticles = [
        Article(articleUrl: "www.article1.com", title: "Title1", authorName: "Author1",
                publishedDate: Date(), section: "Category1", media: nil, summary: "Summary of the 1st article"),
        Article(articleUrl: "www.article2.com", title: "Title2", authorName: "Author2",
                publishedDate: Date(), section: "Category2", media: nil, summary: "Summary of the 2nd article")
    ]
    
    func getArticles<T: Codable>(_ completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(wait)) { [weak self] in
            guard let self = self else {
                completion(.failure(.unknown))
                return
            }
            if self.simulateError {
                completion(.failure(NetworkErrors.notFound))
            } else {
                let response = ArticlesResponse(status: "ok", results: self.sampleArticles, number: 2, copyright: nil)
                if let result = response as? T {
                    completion(.success(result))
                } else {
                    completion(.failure(.unknown))
                }
                
            }
        }
    }
}

class MockedArticlesCoordinator: ArticlesListCoordinatorType {
    
    var articleToNavigate: Article?
    
    func naviagteToArticle(_ article: Article) {
        articleToNavigate = article
    }
    
}
