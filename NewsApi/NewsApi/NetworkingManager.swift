//
//  NetworkingManager.swift
//  NewsApi
//
//  Created by Adnan Alg on 2021-04-23.
//

import Foundation
import UIKit
//delegate Protocole
protocol NetworkingDelegateProtocol {
    
    func networkingDelegateDidFinishWithData(result:News)

}

//NetworkManager to handel the Api
class NetworkManager {
    //Optinal variable to get the result later
    var delegate:NetworkingDelegateProtocol?
   
    //fetch data from incoming Api  and Url declaration
    func fetchData(urlString:String){
        //guard to check the connection status
        guard let urlObject = URL(string:urlString) else {return}
        //start session(Thread) to handle and get the data from the network
        let sessin = URLSession(configuration: .default)
        sessin.dataTask(with: urlObject){
            (data,response,error)
            in
            //checking for errors
            if let error = error {
                print("error adnan",error)
                return
            }
            
            //check for response
            guard let httprespons = response as? HTTPURLResponse , (200...299).contains(httprespons.statusCode) else {
                print("status adnan category api")
                return
            }
            //decode data
            if let mydata = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let  result = try decoder.decode(News.self, from: mydata)
                    if let myDelegate=self.delegate{
                        
                        myDelegate.networkingDelegateDidFinishWithData(result: result)
                        
                    }
                }catch {
                    print ("Sorry, There was a problem during data decoding")
                }
            }
        }.resume()
    }
    
}
    
//This extension to doenload the image from url

extension UIImageView{
    
    func downloadImage(from url: String){
        
        if let articleURL=URL(string:url){
        
            
        let task=URLSession.shared.dataTask(with: URLRequest(url:articleURL)){
            (data,response,error) in
            
            if error != nil{
          
                print(error as Any)
            }
            DispatchQueue.main.async {
                if let data1=data{
                self.image=UIImage(data: data1)
                }
            }
        }
        task.resume()
        }
    }
    
    /*
     
     Some Additional Api Keys. The Api key is limited to 100 request a day for free
       apiKey=0e19db0461e64f4cb992e9536bba9bb5
       
        &apiKey=eb1ec276b39f497d81fe2723d39afb56
      apiKey=3885336ecb3e4b849cadfd04a9c06453
      apiKey=aa22642404aa40a2bf4d9a8737d4ef72
      apiKey=0e19db0461e64f4cb992e9536bba9bb5
         
     */
    
    
    
    
}
