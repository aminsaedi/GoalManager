//
//  Api.swift
//  GoalManager
//
//  Created by Amin Saedi on 2023-04-01.
//

import Foundation

class Goal: Codable {
    let label: String
    let importance: String
    let progress: Float
    let color: [String: Int]
    
    enum CodingKeys: String, CodingKey {
        case label
        case importance
        case progress
        case color
    }
    
    init(label: String, importance: String, progress: Float, color: [String: Int]) {
        self.label = label
        self.importance = importance
        self.progress = progress
        self.color = color
    }
    
    
}

class ObjectAPI {
    static let baseURL = "http://rr.saedi.me:3000/objects"
    
    static func read(completionHandler: @escaping (Error?, [Goal]?) -> Void) {
        let url = URL(string: "\(baseURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(error, nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(NSError(domain: "com.example.ObjectAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"]), nil)
                return
            }
            
            guard let data = data else {
                completionHandler(NSError(domain: "com.example.ObjectAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"]), nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let objects = try decoder.decode([Goal].self, from: data)
                completionHandler(nil, objects)
            } catch {
                completionHandler(error, nil)
            }
        }
        task.resume()
    }
    
    
    static func update(id: Int, object: Goal, completion: @escaping (Error?, Goal?) -> Void) {
        var request = URLRequest(url: URL(string: "\(baseURL)/\(id)")!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(object)
        request.httpBody = jsonData
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error, nil)
            } else if let data = data,
                      let object = try? JSONDecoder().decode(Goal.self, from: data) {
                completion(nil, object)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    static func create(object: Goal, completion: @escaping (Error?, Goal?) -> Void) {
        var request = URLRequest(url: URL(string: "\(baseURL)")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(object)
        request.httpBody = jsonData
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error, nil)
            } else if let data = data,
                      let object = try? JSONDecoder().decode(Goal.self, from: data) {
                completion(nil, object)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    
    static func delete(id: Int, completion: @escaping (Error?) -> Void) {
        var request = URLRequest(url: URL(string: "\(baseURL)/\(id)")!)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
}
