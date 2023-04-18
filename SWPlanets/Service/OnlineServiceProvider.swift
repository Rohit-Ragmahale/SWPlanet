//
//  OnlinePlanetServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

private let planetURL = "https://swapi.dev/api/planets/?page="

struct OnlinePlanetServiceProvider: ServiceProvider {
    
    let urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }

    func getPlanetList(pageId: String, completionHandler: @escaping ((PlanetList?, ServiceErrors?)-> Void)) {
        let pageUrl = planetURL + pageId
        
        guard let url = URL(string: pageUrl) else {
            return
        }
        
        let _ = urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(nil, .serviceError)
                return
            }
            guard 200..<300 ~= response.statusCode else {
                completionHandler(nil, .serviceError)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, .serviceError)
                return
            }
            do {
                let decoder = JSONDecoder()
                let list = try decoder.decode(PlanetList.self, from: data)
                completionHandler(list, nil)
            } catch {
                completionHandler(nil, .dataDecodingError)
            }

            
        }.resume()
    }
}
