//
//  FavoriteTableViewController.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-24.
//

import UIKit
//This class to handle CoreData
class FavoriteTableViewController: UITableViewController {
    //Declaration
    //This array to save Coredata objects(articles)
    var FavoriteArticleFromcoreData = [ArticleCoreData]()
    //object to delete in CoreData
    var articleCoreData:ArticleCoreData=ArticleCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteArticleFromcoreData=CoreDataManager.shared.fetchArticles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var count:Int=0
        if !FavoriteArticleFromcoreData.isEmpty{
            count=FavoriteArticleFromcoreData.count
        }else{
          count=0
            
        }
        return count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCell
        
        if !FavoriteArticleFromcoreData.isEmpty{
            //date Format
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .full
            formatter.timeZone = TimeZone.current
            let articleDate=formatter.string(from: FavoriteArticleFromcoreData[indexPath.row].publishedAt ?? Date())
            cell.ArticleDate?.text = articleDate
            
            cell.ArticleTitle?.text=FavoriteArticleFromcoreData[indexPath.row].title
            if let articleImage=FavoriteArticleFromcoreData[indexPath.row].urlToImage{
                cell.ArticleImage.downloadImage(from: articleImage)
            }
        }
        return cell
    }
    
    //This function to delete the select row from coreData
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            articleCoreData = self.FavoriteArticleFromcoreData[indexPath.row]
            CoreDataManager.shared.deleteArticle(articletodelete: articleCoreData)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            FavoriteArticleFromcoreData=CoreDataManager.shared.fetchArticles()
            self.tableView.reloadData()
        }
        }
    
    //send the data to WebViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoriteTableViewController"{
            if  let newsDetailsVc=segue.destination as? WebViewController{
                if let index=tableView.indexPathForSelectedRow?.row  {
                    newsDetailsVc.articleUrl=self.FavoriteArticleFromcoreData[index].url!
                }
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
    

