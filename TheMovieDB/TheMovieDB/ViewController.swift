//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    let url = "https://api.themoviedb.org/3/"
    let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

