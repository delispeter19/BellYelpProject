//
//  ViewPresenter.swift
//  yelpCloneProj
//
//  Created by Peter Delis on 2022-08-03.
//

import Foundation

class ViewPresenter {
    
    weak var controller: ViewController?
    
    let networkHandler = NetworkHandler()
    
    // business names and terms
    private let terms = ["food", "restaurants", "starbucks", "tim hortons"]
    
    // types of food and cusisines
    private let categories = ["bars", "greek", "french"]
    
    private let defaultCity = "Montreal"
    
    private let businessSearchUrlString = "https://api.yelp.com/v3/businesses/search"
    
    private let businessDetailsUrlString = "https://api.yelp.com/v3/businesses/"
    
    func determineAPISearchParameters(for searchText: String) -> [YelpSearchType: String]{
        var params: [YelpSearchType: String] = [:]
        let text = searchText.lowercased()

        for term in terms {
            if text == term {
                params[.term] = text
                break
            }
        }
        
        for category in categories {
            if text == category {
                params[.category] = text
                break
            }
        }
        
        if params.isEmpty {
            params[.location] = text
        } else {
            params[.location] = defaultCity
        }
        
        return params
    }
    
    func yelpAPISearchBusinessBy(id: String, _ completion: @escaping((YelpBusiness) -> Void)) {
        let urlComponents = URLComponents(string: businessDetailsUrlString + id)!

        let url = urlComponents.url!
        
        networkHandler.executeNetworkRequest(url, completion)
    }
    
    func yelpAPISearchBusinessesBy(_ params: [YelpSearchType: String], _ completion: @escaping((YelpBusinesses) -> Void)) {
        var urlComponents = URLComponents(string: businessSearchUrlString)!

        var queryItems: [URLQueryItem] = []
        
        for (searchType, value) in params {
            queryItems.append(URLQueryItem(name: searchType.rawValue, value: value))
        }
        
        urlComponents.queryItems = queryItems

        let url = urlComponents.url!
        
        networkHandler.executeNetworkRequest(url, completion)
    }
    
}

