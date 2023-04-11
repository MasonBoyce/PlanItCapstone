//
//  YelpApi.swift
//  PlanIt
//
//  Created by Mason Boyce on 12/5/22.
//

import Foundation
struct Venue: Codable {
    var name: String?
    var id: String?
    var rating: Float?
    var price: String?
    var is_closed: Bool?
    var distance: Double?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var selected: Bool? = false
//    var selected: String?
//    static let locations = [Venue(name:"Common")]
}


struct SearchResult: Codable {
    let businesses: [Venue]
}

struct AutocompleteResult: Codable {
    let terms: [String]
}


class YelpApi{
//    TUTORIAL By https://medium.com/@khansaryan/yelp-fusion-api-integration-af50dd186a6e
    
//    var viewcontroller: SelectVenuesViewController?
    let apiKey: String = "mvMizN0RpyOsWy8v9KDxnYw_e-RARw_7NR-KhyHhnI8dgX3SYGKE-q2-9XVLEY12FAKiSEpSjYUzG6VLPpjwgQYfD5lmrTi18hvk7mDnrEL-bfL44X1-HLaQideNY3Yx"
    
    
    func searchVenues(searchQuery: String, latitude: Double, longitude: Double, completion: @escaping ([Venue]?, Error?) -> Void) {
        
        let headers = ["Authorization": "Bearer \(apiKey)"]
        let parameters = ["term": searchQuery, "latitude": String(latitude), "longitude": String(longitude)]

        guard var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }

        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents.url else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(SearchResult.self, from: data)
                completion(result.businesses, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
        
    
    func retriveVenues(latitude: Double, longitude: Double, category: String, limit: Int, sortBy: String, locale:String, completionHandler: @escaping([Venue]?, Error?)-> Void ) {
       
        let baseUrl = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
        
        let url: URL = URL(string: baseUrl)!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data,reponse,error) in
            if let error = error {
                completionHandler(nil,error)
            }
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                guard let resp = json as? NSDictionary else {return}
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else {return}
                
                var venuesList: [Venue] = []
                
                
                
                for business in businesses {
                    let address =  business.value(forKeyPath: "location.display_address") as? [String]
                    
                    var venue = Venue()
                    venue.name = business.value(forKey: "name") as? String
                    venue.id = business.value(forKey: "id") as? String
                    venue.rating = business.value(forKey: "rating") as? Float
                    venue.price = business.value(forKey: "price") as? String
                    venue.is_closed = business.value(forKey: "is_closed") as? Bool
                    venue.distance = business.value(forKey: "distance") as? Double
                    venue.address = address?.joined(separator: "\n")
                    venue.latitude = business.value(forKeyPath: "coordinates.latitude") as? Double
                    venue.longitude = business.value(forKeyPath: "coordinates.longitude") as? Double
                    
                    venuesList.append(venue)
                
                }
                completionHandler(venuesList,nil)
            } catch {
                print("ERROR RIGHT HERE \(error)")
            }
        }.resume()
    }
}


func autocomplete(text: String, latitude: Double, longitude: Double, completion: @escaping ([String]?, Error?) -> Void) {
    let apiKey = "your_api_key"
    let headers = ["Authorization": "Bearer \(apiKey)"]
    let parameters = ["text": text, "latitude": String(latitude), "longitude": String(longitude)]

    guard var urlComponents = URLComponents(string: "https://api.yelp.com/v3/autocomplete") else {
        completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        return
    }

    urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    guard let url = urlComponents.url else {
        completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        return
    }

    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion(nil, error)
            return
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(AutocompleteResult.self, from: data)
            completion(result.terms, nil)
        } catch {
            completion(nil, error)
        }
    }

    task.resume()
}



