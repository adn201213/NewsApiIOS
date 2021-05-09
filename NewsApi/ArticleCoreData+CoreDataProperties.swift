//
//  ArticleCoreData+CoreDataProperties.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//
//

import Foundation
import CoreData


extension ArticleCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleCoreData> {
        return NSFetchRequest<ArticleCoreData>(entityName: "ArticleCoreData")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?

}

extension ArticleCoreData : Identifiable {

}
