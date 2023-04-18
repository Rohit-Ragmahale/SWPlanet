//
//  OnlinePlanetServiceProvider.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation

private let planetURL = "https://swapi.dev/api/planets/?page=1"

struct OnlinePlanetService: DataServiceProvider {

    let urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default)
    }

    func getPlanetList(completionHandler: @escaping ((PlanetList?, ServiceErrors?)-> Void)) {
        debugPrint("Fetching list from Online Service Provider")
        guard let url = URL(string: planetURL) else {
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
                completionHandler(nil, .dataError)
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
