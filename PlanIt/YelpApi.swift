//
//  YelpApi.swift
//  PlanIt
//
//  Created by Mason Boyce on 12/5/22.
//

import Foundation
struct Venue {
    var name: String?
    var yelpID: String?
    var internalID: Int?
    var rating: Float?
    var price: String?
    var is_closed: Bool?
    var distance: Double?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var time_of_day: String? // 'Morning' | 'Afternoon' | 'Evening' ONLY
}

class YelpApi{
//    TUTORIAL By https://medium.com/@khansaryan/yelp-fusion-api-integration-af50dd186a6e
    
    func retriveVenues(latitude: Double, longitude: Double, category: String, limit: Int, sortBy: String, locale:String, completionHandler: @escaping([Venue]?, Error?)-> Void ) {
        let apiKey = "mvMizN0RpyOsWy8v9KDxnYw_e-RARw_7NR-KhyHhnI8dgX3SYGKE-q2-9XVLEY12FAKiSEpSjYUzG6VLPpjwgQYfD5lmrTi18hvk7mDnrEL-bfL44X1-HLaQideNY3Yx"
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
                    venue.internalID = business.value(forKey: "id") as? Int
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
