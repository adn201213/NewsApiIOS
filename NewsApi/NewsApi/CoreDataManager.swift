//
//  CoreDataManager.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//

import Foundation
import CoreData
//Core Data class

class CoreDataManager{
    
    static var shared = CoreDataManager()
  /*
    func saveNewArticle(urlToImage:String?,url:String,title: String,publishedAt: Date,content:String?,author:String?,articleDescription: String?){
        
        let newArticle = ArticleCoreData(context: persistentContainer.viewContext)
        
        newArticle.urlToImage=urlToImage
        newArticle.url=url
        newArticle.title=title
        newArticle.publishedAt=publishedAt
        newArticle.content=content
        newArticle.author=author
        newArticle.articleDescription=articleDescription
        saveContext()
    }
 */
    //save function by object parameter
    func saveNewArticleObject(articleToSave:ArticleAPI){
        
        let newArticle = ArticleCoreData(context: persistentContainer.viewContext)
        
        newArticle.urlToImage=articleToSave.urlToImage
        newArticle.url=articleToSave.url
        newArticle.title=articleToSave.title
        newArticle.publishedAt=articleToSave.publishedAt
        newArticle.content=articleToSave.content
        newArticle.author=articleToSave.author
        newArticle.articleDescription=articleToSave.articleDescription
        saveContext()
    }
    //delete function
    func deleteArticle(articletodelete:ArticleCoreData){
        persistentContainer.viewContext.delete(articletodelete)
        saveContext()
    }
    //get articles
    func fetchArticles()->[ArticleCoreData]{
        
        let fetch :NSFetchRequest=ArticleCoreData.fetchRequest()
      //  fetch.sortDescriptors=[NSSortDescriptor.init(key: "title",ascending: true)]
        var result=[ArticleCoreData]()
        do{
        result = try persistentContainer.viewContext.fetch(fetch)
   
        }
        catch{
            print("error from core data")
            
        }
        return result
        }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name:"NewsApi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error from core data\(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
           
                let nserror = error as NSError
                fatalError("Unresolved error from save Context core data \(nserror), \(nserror.userInfo)")
            }
        }
    
    }
   
}
