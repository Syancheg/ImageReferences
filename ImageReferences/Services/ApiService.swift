//
//  ApiService.swift
//  ImageReferences
//
//  Created by Константин Кузнецов on 22.05.2022.
//

import Foundation

class ApiService {
    
    // MARK: - Private properties
    
    private let url = "http://syancheg.xyz/api/"
    private let decoder = JSONDecoder()
    
    // MARK: - Functions
    
    func getFilters(completion: @escaping ([FilterGroup]?) -> Void) {
        let url = url + "filter"
        getRequest(url: url, parameters: [:]) { data in
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
        let url = url + "image"
        getRequest(url: url, parameters: filter) { data in
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
    
    private func getRequest(url: String, parameters: [String:Int], completion: @escaping (Data?) -> Void ){
        let url = setupQueryParameners(url: url, parameters: parameters)
        guard let requestUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: requestUrl) {(data, response, error) in
            guard let data = data else { return }
            completion(data)
        }
        task.resume()
    }
    
    private func setupQueryParameners(url: String, parameters: [String:Int]) -> String {
        var url = url
        if parameters != [:] {
            url += "?"
            var index = 1
            for (code, id) in parameters {
                url += "\(code)=\(id)"
                if (index < parameters.count) {
                    url += "&"
                }
                index += 1
            }
        }
        return url
    }
    
}
