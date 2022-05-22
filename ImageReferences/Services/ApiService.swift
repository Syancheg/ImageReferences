//
//  ApiService.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 22.05.2022.
//

import Foundation

class ApiService {
    
    private let url = "http://127.0.0.1:8000/api/"
    let decoder = JSONDecoder()
    
    func getFilters(completion: @escaping ([FilterGroup]?) -> Void) {
        let url = self.url + "filter"
        getRequest(url: url) { data in
            guard let data = data else { return }
            do {
                let filters = try self.decoder.decode([FilterGroup].self, from: data)
                completion(filters)
            } catch {
                print(error)
            }
        }
    }
    
    func getImage(with filter: [Int:Int], completion: @escaping (Image) -> Void) {
        let url = self.url + "image"
        getRequest(url: url) { data in
            guard let data = data else { return }
            do {
                let image = try self.decoder.decode(Image.self, from: data)
                completion(image)
            } catch {
                print(error)
            }
        }
    }
    
    private func getRequest(url: String, completion: @escaping (Data?) -> Void ){
        let requestUrl = URL(string: url)!
        let task = URLSession.shared.dataTask(with: requestUrl) {(data, response, error) in
            guard let data = data else { return }
            completion(data)
        }
        task.resume()
    }
    
}
