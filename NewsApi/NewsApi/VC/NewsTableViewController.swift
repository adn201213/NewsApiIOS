//
//  NewsByCountryTableViewController.swift
//  NewsApi
//
/*
Some Additional Api Keys. The Api key is limited to 100 request a day for free
  apiKey=0e19db0461e64f4cb992e9536bba9bb5
  
   &apiKey=eb1ec276b39f497d81fe2723d39afb56
 apiKey=3885336ecb3e4b849cadfd04a9c06453
 apiKey=aa22642404aa40a2bf4d9a8737d4ef72
 apiKey=0e19db0461e64f4cb992e9536bba9bb5
*/
//  Created by Adnan Alg on 2021-04-23.
//

import UIKit
//This ViewControler to display the news by Country
class NewsTableViewController: UITableViewController,UISearchBarDelegate, NetworkingDelegateProtocol {
    
    //Declaration
    var articlesAPIList:[ArticleAPI]=[ArticleAPI]()
    var manager:NetworkManager=NetworkManager()
    //object to save in CoreData
    // var articleToCoreData:ArticleCoreData=ArticleCoreData()
   //this object to hold data and then save them in CoreData
    var articleAPI:ArticleAPI=ArticleAPI()
    
    //Intitial Loading for news, I put Canada as hard code,so The user can see Canada News on the loading. we can put any country
    //on the search button, then it will be change due the search text value
    let country:String="ca"
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        let urlString="https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=aa22642404aa40a2bf4d9a8737d4ef72"
        manager.fetchData(urlString: urlString)
    }
    //for search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if !searchText.isEmpty{
            let urlString="https://newsapi.org/v2/top-headlines?country=\(searchText)&apiKey=aa22642404aa40a2bf4d9a8737d4ef72"
            manager.fetchData(urlString:urlString)
            self.tableView.reloadData()
        }
        else{
            manager.fetchData(urlString:"")
        }
    }
    //conform delegate protocol, fetch the data and fill the arraylist then send to main thread
    func networkingDelegateDidFinishWithData(result:News) {
        if !result.articles.isEmpty{
            self.articlesAPIList = result.articles
        }else{
            self.articlesAPIList=[ArticleAPI]()
        }
        // Main Thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var count:Int=0
        if !articlesAPIList.isEmpty{
            //only check on consol
            print(articlesAPIList.count)
            count=articlesAPIList.count
        }
        
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        
        if !articlesAPIList.isEmpty{
            cell.Articletitle?.text=articlesAPIList[indexPath.row].title
            cell.ArticleAuthor?.text=articlesAPIList[indexPath.row].source.name
        //date format
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .full
            formatter.timeZone = TimeZone.current
            let articleDate=formatter.string(from: articlesAPIList[indexPath.row].publishedAt)
            cell.ArticleDate?.text = articleDate
            if let articleImage=articlesAPIList[indexPath.row].urlToImage{
                print("this title from general\(articlesAPIList[indexPath.row].title)")
                cell.AricleImage.downloadImage(from: articleImage)
            }
        }
        return cell
        
    }
    //send the data to WebViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsByCountryTableViewController"{
            if  let newsDetailsVc=segue.destination as? WebViewController{
                if let index=tableView.indexPathForSelectedRow?.row  {
                    newsDetailsVc.articleUrl=self.articlesAPIList[index].url
                }
            }
        }
    }
    
   /*
    func addArticleToCoreData(article:ArticleAPI) {
        
        
        CoreDataManager.shared.saveNewArticle(urlToImage: article.urlToImage,
        url: article.url, title: article.title, publishedAt: article.publishedAt,
        content: article.content, author:article.author,articleDescription: article.articleDescription)
    }
    */
    //This functio to save the selected row in CoreData
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let insertAction = UIContextualAction(style: .normal, title: "Save") { (_, _, completionHandler) in
            self.articleAPI.author=self.articlesAPIList[indexPath.row].author
            self.articleAPI.title=self.articlesAPIList[indexPath.row].title
            self.articleAPI.content=self.articlesAPIList[indexPath.row].content
            self.articleAPI.publishedAt=self.articlesAPIList[indexPath.row].publishedAt
            self.articleAPI.url=self.articlesAPIList[indexPath.row].url
            self.articleAPI.urlToImage=self.articlesAPIList[indexPath.row].urlToImage
            self.articleAPI.articleDescription=self.articlesAPIList[indexPath.row].articleDescription
            
            CoreDataManager.shared.saveNewArticleObject(articleToSave: self.articleAPI)
            
            self.tableView.reloadData()
            
            
            completionHandler(true)
        }
        
        insertAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        // insertAction.image = UIImage(named: "favorite-96")
        
        return UISwipeActionsConfiguration(actions: [insertAction])
    }
    
}

