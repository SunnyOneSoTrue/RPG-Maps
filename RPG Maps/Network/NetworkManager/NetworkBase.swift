//
//  NetworkBase.swift
//  RPG Maps
//
//  Created by USER on 18.07.21.
//

import SwiftUI

typealias completion<T: Codable> = ((Result<T, Error>) -> Void)

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func get<T: Codable>(url: String, completion: @escaping completion<T>) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {return}
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }

}
