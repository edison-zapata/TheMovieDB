//
//  MovieDbAPICaller.swift
//  TheMovieDB
//
//  Created by Edison Zapata Henao on 3/1/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import Foundation
import Alamofire

class MovieDbAPICaller {
    
    let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    let url = "https://api.themoviedb.org/3/"
    let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
    
    struct MovieListResponse : Codable {
        var page: Int
        var results: [Movie]
        var total_pages: Int
        var total_results: Int
    }
    
    func URLSessionRequest(){
        var request = URLRequest(url: NSURL(string: "\(url)discover/movie?page=1&include_video=false&include_adult=false&sort_by:popularity.desc&language=en-US&api_key=\(apiKey)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = self.postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if(error != nil){
                print("ERROR:\n")
                print(error ?? "Unidentified Error")
            }else{
                do{
                    print(try JSONSerialization.jsonObject(with: data!, options: []))
                }catch let parsingError{
                    print("ERROR:\n\(parsingError)")
                }
            }
        })
        
        dataTask.resume()
    }
    
    /*private func movieListRequestHandler(response: DataResponse<Any>){
        
    }*/
    
    public func getMovieList(pageID: Int, completionHandler: @escaping (MovieListResponse) -> Void){
        print("Sending requiest")
        Alamofire.request("\(url)discover/movie?page=\(pageID)&sort_by:popularity.des&api_key=\(apiKey)").responseJSON{ response in
            do {
                completionHandler(try JSONDecoder().decode(MovieListResponse.self, from: response.data ?? self.postData as Data))
            } catch let error {
                print (error)
                return
            }
        }
        print("Request send")
    }
    
    public func getMovieDetails(movieID: Int, completionHandler: @escaping (Movie) -> Void){
        Alamofire.request("\(url)movie/\(movieID)?api_key=\(apiKey)").responseData { data in
            do{
                completionHandler(try JSONDecoder().decode(Movie.self, from: data.data!))
            }catch let error{
                print(error)
            }
        }
    }
}
