//
//  NetworkService.swift
//  NetworkService
//
//  Created by t.lolaev on 18.04.2022.
//

public enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

public struct NetworkService {
    
    public static func runTask(with config: AppConfiguration) {
        if let url = URL(string: config.rawValue) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data, let encodedData = String(data: data, encoding: .utf8) {
                    print(encodedData)
                }
                
                if let response = response as? HTTPURLResponse {
                    print(response.allHeaderFields)
                    print(response.statusCode)
                }
                
                if let error = error {
                    print(error.localizedDescription.debugDescription)
                }
            }
            task.resume()
        }
    }
    
}
