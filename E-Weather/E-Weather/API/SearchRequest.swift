//
//  SearchRequest.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import Alamofire
import Foundation

class SearchRequest {
    
    func search(cityName: String, onComplete: @escaping (_ cities: [City]?, _ error: Error?) -> ()) {
        
        let request = AF.request("https://www.metaweather.com/api/location/search/?query=\(cityName)")
        
        request.responseDecodable(of: [City].self) { response in
            
            guard let cities = response.value else {
                if let error = response.error {
                    onComplete(nil, error)
                }
                return
            }
            
            if let error = response.error {
                onComplete(nil, error)
            } else {
                onComplete(cities, nil)
            }

        }
        
    }
}
