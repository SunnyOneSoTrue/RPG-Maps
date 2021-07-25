//
//  LocationsNetworkManager.swift
//  RPG Maps
//
//  Created by USER on 18.07.21.
//

import Foundation

typealias callbackBlock = ((Data) -> Void)

protocol LocationsManagerProtocol: AnyObject {
    func fetchData(completion: @escaping callbackBlock)
}

class LocationsManager: LocationsManagerProtocol {
    func fetchData(completion: @escaping (Data) -> Void) {
        let urlString = "https://run.mocky.io/v3/1ffc5637-7ded-48f9-bc37-e587ae385440"
        NetworkManager.shared.get(url: urlString) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let err):
                print(err)
            }
        }
    }
}
