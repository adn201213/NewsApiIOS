//
//  NewsByCategoryTableTableViewController.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-24.
//

import UIKit

class ArticlesTableViewController: UITableViewController,UISearchBarDelegate,NetworkingDelegateProtocol {

  
    //Declaration
    var articlesAPIList:[ArticleAPI]=[ArticleAPI]()
    var manager:NetworkManager=NetworkManager()
    let country:String="us"
    let category:String="sport"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
      //  let urlString="https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=3885336ecb3e4b849cadfd04a9c06453"
         
        
         let urlString="https://newsapi.org/v2/everything?q=apple&from=2021-04-23&to=2021-04-23&sortBy=popularity&apiKey=3885336ecb3e4b849cadfd04a9c06453"

        manager.fetchData(urlString: urlString)
    }
    
    //for search
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
           print(searchText)
         if !searchText.isEmpty{
/*
             let
                urlString="https://newsapi.org/v2/top-headlines?country=\(country)&category=\(searchText)&apiKey=3885336ecb3e4b849cadfd04a9c06453"
            
          */
 
 let
            urlString="https://newsapi.org/v2/everything?q=\(searchText)&from=2021-04-23&to=2021-04-23&sortBy=popularity&apiKey=3885336ecb3e4b849cadfd04a9c06453"
            
            
           
         
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleByCategoryCell
        
        if !articlesAPIList.isEmpty{
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
           if segue.identifier == "NewsByCategoryTableViewController"{
               if  let newsDetailsVc=segue.destination as? WebViewController{
                  if let index=tableView.indexPathForSelectedRow?.row  {
                    newsDetailsVc.articleUrl=self.articlesAPIList[index].url
                   }
               }
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

}
