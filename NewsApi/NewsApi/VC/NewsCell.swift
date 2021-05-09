//
//  ArticleByCountryCell.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//

import UIKit
//This class for custom cell in NewsTableViewController
class NewsCell: UITableViewCell {

    @IBOutlet weak var AricleImage: UIImageView!
    
    @IBOutlet weak var Articletitle: UILabel!
    
    @IBOutlet weak var ArticleDate: UILabel!
    
    @IBOutlet weak var ArticleAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
