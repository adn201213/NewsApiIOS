//
//  ArticleByCategoryCellTableViewCell.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-24.
//

import UIKit
//This class for custom cell in ArticleTableViewController
class ArticleCell: UITableViewCell {

    @IBOutlet weak var ArticleImage: UIImageView!
  
    @IBOutlet weak var ArticleTitle: UILabel!
    
    @IBOutlet weak var ArticleAuthor: UILabel!
    
    @IBOutlet weak var ArticleDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
