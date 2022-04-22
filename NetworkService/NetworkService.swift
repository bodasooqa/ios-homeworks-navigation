//
//  NetworkService.swift
//  NetworkService
//
//  Created by t.lolaev on 18.04.2022.
//

public struct NetworkService {
    
    public enum AppConfiguration: String, CaseIterable {
        case people = "https://swapi.dev/api/people/8"
        case starships = "https://swapi.dev/api/starships/3"
        case planets = "https://swapi.dev/api/planets/5"
    }
    
    public typealias Todo = [String: Any]
    
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
    
    public static func getTodo(callback: @escaping (String) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let serializedData = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        if let dict = serializedData as? Todo, let title = dict["title"] as? String {
                            callback(title)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
}
