//
//  NetworkService.swift
//  NetworkService
//
//  Created by t.lolaev on 18.04.2022.
//

struct Planet: Decodable {
    let name: String
    let orbitalPeriod: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
    }
}

struct Todo {
    let title: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as! String
    }
}

public struct NetworkService {
    
    public enum AppConfiguration: String, CaseIterable {
        case people = "https://swapi.dev/api/people/8"
        case starships = "https://swapi.dev/api/starships/3"
        case planets = "https://swapi.dev/api/planets/5"
    }
    
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
    
    private static func makeRequest(url: String, successCallback: @escaping (Data) throws -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        try successCallback(unwrappedData)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    public static func getTodo(callback: @escaping (String) -> Void) {
        Self.makeRequest(url: "https://jsonplaceholder.typicode.com/todos/1") { data in
            let serializedData = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = serializedData as? [String: Any] {
                let todo = Todo(dictionary: dict)
                callback(todo.title)
            }
        }
    }
    
    public static func getPlanet(callback: @escaping (String) -> Void) {
        Self.makeRequest(url: "https://swapi.dev/api/planets/1/") { data in
            let decodedData = try JSONDecoder().decode(Planet.self, from: data)
            callback("\(decodedData.name) — \(decodedData.orbitalPeriod)")
        }
    }
    
}
