//
//  DetailsRequest.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import Alamofire
import Foundation

class DetailsRequest {
    
 
    func get(woeid: Int, onComplete: @escaping (_ details: CityDetails?, _ error: Error?) -> ()) {
        
        let request = AF.request("https://www.metaweather.com/api/location/\(woeid)/")
        
        request.responseDecodable(of: CityDetails.self) { response in
            
            guard let details = response.value else {
                if let error = response.error {
                    onComplete(nil, error)
                }
                return
            }
            if let error = response.error {
                onComplete(nil, error)
            } else {
                onComplete(details, nil)
            }
                        
        }
            
    }
}

