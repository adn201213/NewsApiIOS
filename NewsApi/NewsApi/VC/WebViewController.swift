//
//  WebViewController.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//

import UIKit
import WebKit
//This class to display the news website when the user select a row
class WebViewController: UIViewController,WKUIDelegate{
    var articleUrl:String=""
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:articleUrl)
        if let webUrl=myURL{
            let myRequest = URLRequest(url: webUrl)
        
            webView.load(myRequest)
        }
        // Do any additional setup after loading the view.
    }
    override func loadView() {
          let webConfiguration = WKWebViewConfiguration()
          webView = WKWebView(frame: .zero, configuration: webConfiguration)
          webView.uiDelegate = self
          view = webView
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
