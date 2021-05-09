//
//  Model.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//

import Foundation

// News Model
class News: Codable {
    var status: String
    var totalResults: Int
    var articles: [ArticleAPI]
    init(status: String, totalResults: Int, articles: [ArticleAPI]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

//Article Model
class ArticleAPI: Codable {
    var source: Source1
    var author: String?
    var title: String
    var articleDescription: String?
    var url: String
    var urlToImage: String?
    var publishedAt: Date
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }

    init(source: Source1, author: String?, title: String, articleDescription: String?, url: String, urlToImage: String?, publishedAt: Date, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    init(){
        self.source = Source1()
        self.author = ""
        self.title = ""
        self.articleDescription = ""
        self.url = ""
        self.urlToImage = ""
        self.publishedAt = Date()
        self.content = ""
    }
  
}

// Source Model
class Source1: Codable {
    var id: String?
    var name: String

    init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
    init(){
        
        self.id = ""
        self.name = ""
        
    }
}



