//
//  ApiService.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 22.05.2022.
//

import Foundation

class ApiService {
    
    // MARK: - Private properties
    
    private let decoder = JSONDecoder()
    
    // MARK: - Functions
    
    func getFilters(completion: @escaping ([FilterGroup]?) -> Void) {
        let query = "filter"
        getRequest(query: query, parameters: [:]) { data in
            guard let data = data else { return }
            do {
                let filters = try self.decoder.decode([FilterGroup].self, from: data)
                completion(filters)
            } catch {
                completion(nil)
            }
        }
    }

    func getImage(with filter: [String:Int], completion: @escaping (Image?) -> Void) {
        let query = "image"
        getRequest(query: query, parameters: filter) { data in
            guard let data = data else { return }
            do {
                let image = try self.decoder.decode(Image.self, from: data)
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }
    
    // MARK: - Private Function
    
    private func getRequest(query: String, parameters: [String:Int], completion: @escaping (Data?) -> Void ){
        var components = URLComponents()
        components.scheme = "http"
        components.host = "syancheg.xyz"
        components.path = "/api/\(query)"
        components.queryItems = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: String(value))
        }
        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            completion(data)
        }
        task.resume()
    }
    
}
