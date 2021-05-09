//
//  NewsByCategoryTableTableViewController.swift
//  NewsApi

/*
 Some Additional Api Keys. The Api key is limited to 100 request a day for free
 apiKey=0e19db0461e64f4cb992e9536bba9bb5
 
 &apiKey=eb1ec276b39f497d81fe2723d39afb56
 apiKey=3885336ecb3e4b849cadfd04a9c06453
 apiKey=aa22642404aa40a2bf4d9a8737d4ef72
 apiKey=0e19db0461e64f4cb992e9536bba9bb5
 */
//
//  Created by Adnan Alg on 2021-04-24.
//

import UIKit

class ArticlesTableViewController: UITableViewController,UISearchBarDelegate,NetworkingDelegateProtocol {
    
    
    //Declaration
    var articlesAPIList:[ArticleAPI]=[ArticleAPI]()
    var manager:NetworkManager=NetworkManager()
    //object to save in CoreData
    // var articleToCoreData:ArticleCoreData=ArticleCoreData()
    var articleAPI:ArticleAPI=ArticleAPI()
    /*Intitial Loading for news, I put Apple as hard code,so The user can see the recent article about Appleon the loading.
     we can put any keyword
     on the search button, then it will be change due the search text value*/
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        let urlString="https://newsapi.org/v2/everything?q=apple&from=2021-04-23&to=2021-04-23&sortBy=popularity&apiKey=aa22642404aa40a2bf4d9a8737d4ef72"
        
        manager.fetchData(urlString: urlString)
    }
    
    //for search article by keyword
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchText)
        if !searchText.isEmpty{
            let urlString="https://newsapi.org/v2/everything?q=\(searchText)&from=2021-04-23&to=2021-04-23&sortBy=popularity&apiKey=aa22642404aa40a2bf4d9a8737d4ef72"
            manager.fetchData(urlString:urlString)
            self.tableView.reloadData()
        }
        else{
            manager.fetchData(urlString:"")
        }
    }
    
    //conform delegate protocol, fetch the data and fill the arraylist then send to main thread
    func networkingDelegateDidFinishWithData(result:News) {
        print("count from main table\(self.articlesAPIList.count)")
        
        if !result.articles.isEmpty{
            self.articlesAPIList = result.articles
            
        }else{
            self.articlesAPIList=[ArticleAPI]()
        }
        // Main Thread
        DispatchQueue.main.async {
            //this only to check my work in the console
            print("count from main table\(self.articlesAPIList.count)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        
        if !articlesAPIList.isEmpty{
            cell.ArticleAuthor?.text=articlesAPIList[indexPath.row].source.name
            //date format
            
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .full
            formatter.timeZone = TimeZone.current
            let articleDate=formatter.string(from: articlesAPIList[indexPath.row].publishedAt)
            cell.ArticleDate?.text = articleDate
            cell.ArticleTitle?.text=articlesAPIList[indexPath.row].title
            print("this title from general\(articlesAPIList[indexPath.row].title)")
            if let articleImage1=articlesAPIList[indexPath.row].urlToImage{
                cell.ArticleImage.downloadImage(from:articleImage1)
            }
        }else{
            cell.textLabel?.text=""
            cell.detailTextLabel?.text=""
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticlesTableViewController"{
            if  let newsDetailsVc=segue.destination as? WebViewController{
                if let index=tableView.indexPathForSelectedRow?.row  {
                    newsDetailsVc.articleUrl=self.articlesAPIList[index].url
                }
            }
        }
    }
    
    //save selected row in CoreData
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let insertAction = UIContextualAction(style: .normal, title: "Save"){
            (_, _, completionHandler) in
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

/*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

