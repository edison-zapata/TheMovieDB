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
    
    class ConfigResponse : Codable {
        struct Images : Codable {
            var baseURL: String
            var secureBaseURL: String
            var backdropSizes: [String]
            var logoSizes: [String]
            var posterSizes: [String]
            var profileSizes: [String]
            var stillSizes: [String]
            enum CodingKeys : String, CodingKey{
                case baseURL = "base_url"
                case secureBaseURL = "secure_base_url"
                case backdropSizes = "backdrop_sizes"
                case logoSizes = "logo_sizes"
                case posterSizes = "poster_sizes"
                case profileSizes = "profile_sizes"
                case stillSizes = "still_sizes"
                
            }
        }
        var images: Images
    }
    
    static var configs: ConfigResponse?
    
    struct MovieListResponse : Codable {
        var page: Int
        var results: [Movie]
        var total_pages: Int
        var total_results: Int
    }
    
    
    static let API_KEY = "1f4d7de5836b788bdfd897c3e0d0a24b"
    static let BASE_URL = "https://api.themoviedb.org/3/"
    
    
    /*func URLSessionRequest(){
        var request = URLRequest(url: NSURL(string: "\(MovieDbAPICaller.url)discover/movie?page=1&include_video=false&include_adult=false&sort_by:popularity.desc&language=en-US&api_key=\(apiKey)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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
    }*/
    
    static func getConfigs(){
        Alamofire.request("\(BASE_URL)configuration?api_key=\(API_KEY)").responseJSON {
            response in
            do {
                configs = try JSONDecoder().decode(ConfigResponse.self, from: response.data ?? Data())
            }catch let error {
                print(error)
            }
        }
    }
    
    static func getMovieList(pageID: Int, completionHandler: @escaping (MovieListResponse?, Error?) -> Void){
        Alamofire.request("\(BASE_URL)discover/movie?page=\(pageID)&sort_by:popularity.des&api_key=\(API_KEY)").responseJSON{
            response in
            do {
                completionHandler(try JSONDecoder().decode(MovieListResponse.self, from: response.data ?? Data()), nil)
            } catch let error {
                print("MovieDbAPICaller.getMovieList -> \(try! JSONSerialization.jsonObject(with: response.data!, options: []))")
                completionHandler(nil, error)
            }
        }
    }
    
    static func getMovieDetails(movieID: Int, completionHandler: @escaping (Movie) -> Void){
        Alamofire.request("\(BASE_URL)movie/\(movieID)?api_key=\(API_KEY)").responseData { data in
            do{
                completionHandler(try JSONDecoder().decode(Movie.self, from: data.data!))
            }catch let error{
                print(error)
            }
        }
    }
    
    static func getMoviePoster(imageSize: String, imagePath: String, completionHandler: @escaping (Data)->Void){
        guard  let baseUrl = configs?.images.secureBaseURL else {
            return
        }
        Alamofire.request("\(baseUrl)\(imageSize)\(imagePath)").responseData{
            data in
            guard let response = data.data else{
                return
            }
            completionHandler(response)
        }
    }
}
