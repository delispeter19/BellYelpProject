//
//  YelpBusinessElements.swift
//  yelpCloneProj
//
//  Created by Peter Delis on 2022-08-03.
//

import Foundation

enum YelpSearchType: String {
    case location
    case term
    case category
    case locale
    case sort_by
}

struct YelpBusinesses: Codable {
    var total: Int?
    var businesses: [YelpBusiness]?
}

struct YelpBusiness: Codable {
    var name: String?
    var image_url: String?
    var categories: [YelpCategory]?
    var hours: [YelpHours]?
    var location: YelpLocation?
    var rating: Double?
    var price: String?
    var phone: String?
    var id: String?
//    var deals: String? cant find this one??
}

struct YelpCategory: Codable {
    var alias: String?
    var title: String?
}

struct YelpHours: Codable {
    var open: [YelpDailyHours]?
    var hours_type: String?
    var is_open_now: Bool?
}

struct YelpDailyHours: Codable {
    var is_overnight: Bool?
    var start: String?
    var end: String?
    var day: Int?
}

struct YelpLocation: Codable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_address: [String]?
    var cross_streets: String?
}


