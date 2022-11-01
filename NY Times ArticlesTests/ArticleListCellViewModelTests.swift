//
//  ArticleListCellViewModelTests.swift
//  NY Times ArticlesTests
//
//  Created by Najeeb on 01/11/2022.
//

import XCTest
@testable import NY_Times_Articles

class ArticleListCellViewModelTests: XCTestCase {

    var media = Media(type: "image", metadata: [MediaMetadata(url: URL(string: "www.articleimage.com"), format: nil, height: nil, width: nil)])

    var sampleArticle: Article {
        Article(articleUrl: "www.article1.com", title: "Title1", authorName: "By Author1",
                                publishedDate: DateComponents(calendar: .current, year: 2022, month: 10, day: 28).date! ,
                                section: "Category1", media: [media], summary: "Summary of the 1st article")
    }
    
    func test_articleDetails() {
        let sut = ArticleListCellViewModel(article: sampleArticle)
        
        XCTAssertEqual(sut.articleTitle, "Title1")
        
        XCTAssertEqual(sut.authorNameText, "By Author1")
        
        XCTAssertEqual(sut.publishedDate, "Oct 28, 2022")
        
        XCTAssertEqual(sut.articleImageURL?.absoluteString, "www.articleimage.com")
    }

}
