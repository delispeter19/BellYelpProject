//
//  NetworkHandler.swift
//  yelpCloneProj
//
//  Created by Peter Delis on 2022-08-03.
//

import Foundation

class NetworkHandler {
    
    private let token = "QaS_UUIFcezQoC0KEV1xI9TKxp4Ty5887wt0MwG8o15ab3aesbKRxi-zvWLpgUA76B3qfPhn6plSCgY-9wfACD20x4QLVSjzwEmAyjvdLNyXZJuZMzpOTIVGbgTjYnYx"
    
    func executeNetworkRequest<T: Codable>(_ url: URL, _ completion: @escaping((T) -> Void)){
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do {
//                let jsonResp = try JSONSerialization.jsonObject(with: data)
//                debugPrint(jsonResp)
                
                let result = try JSONDecoder().decode(T.self, from: data)
//                DispatchQueue.main.async {
                completion(result)
//                }
                
            } catch let err {
                print("Something went wrong! \(String(describing: err))")
            }
            
        }).resume()
    }
    
}
