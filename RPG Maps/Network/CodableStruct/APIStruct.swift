//
//  APIStruct.swift
//  RPG Maps
//
//  Created by USER on 18.07.21.
//

import Foundation

struct User: Codable {
    let username:String
    let adventurerPoints: Int
    let profilePicture: String
    let backgroundPicture: String
    let badges: [String]
}

struct Location: Codable {
    let name: String
    let coordinates: Coordinates
    let type: String
    let subtitle: String
}

struct Coordinates: Codable {
    let lat: Double
    let lng: Double
}

struct Data: Codable{
    let locations: [Location]
    let users: [User]
}
