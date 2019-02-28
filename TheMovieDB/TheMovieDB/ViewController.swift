//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {
    
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    let url = "https://api.themoviedb.org/3/"
    let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
    
    struct JsonResponse : Codable {
        var page: Int
        var results: [Movie]
        var total_pages: Int
        var total_results: Int
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //URLSession
        /*
        var request = URLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?page=1&include_video=false&include_adult=false&sort_by:popularity.desc&language=en-US&api_key=1f4d7de5836b788bdfd897c3e0d0a24b")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if(error != nil){
                print("ERROR")
                print(error)
            }else{
                do{
                    print(try JSONSerialization.jsonObject(with: data!, options: []))
                }catch let parsingError{
                    
                }
            }
        })
        
        dataTask.resume()
        */
        
        //Alamofire - Movie List
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?page=1&include_video=false&include_adult=false&sort_by:popularity.desc&language=en-US&api_key=1f4d7de5836b788bdfd897c3e0d0a24b").responseJSON { response in
            do {
                guard let jResponse = try JSONDecoder().decode(Optional<JsonResponse>.self, from: response.data ?? "".data(using: .utf8)!)
                    else{
                        return
                }
                print(jResponse.results[1].title)
            } catch let error {
                print (error)
            }
        }
        
        //Single Movie
        Alamofire.request("https://api.themoviedb.org/3/movie/399579?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US").responseData { data in
            let movieObj = try! JSONDecoder().decode(Movie.self, from: data.data!)
            //print(movieObj)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

