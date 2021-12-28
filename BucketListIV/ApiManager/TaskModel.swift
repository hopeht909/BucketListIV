//
//  TaskModel.swift
//  BucketListIV
//
//  Created by admin on 23/05/1443 AH.
//

import Foundation

class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let url = URL(string: "http://localhost:8080/tasks"){
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: completionHandler)
        task.resume()
        }}
    
    static func addTask(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
            if let urlToReq = URL(string: "http://localhost:8080/tasks") {
                var request = URLRequest(url: urlToReq)
                request.httpMethod = "POST"
      
                let bodyData = "objective=\(objective)"
                request.httpBody = bodyData.data(using: .utf8)
       
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    
    static func updateTask(id: String,objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "http://127.0.0.1:8080/tasks/\(id)"){
                var request = URLRequest(url: urlToReq)
                    request.httpMethod = "PUT"
        
                    let bodyData = "objective=\(objective)"
                    request.httpBody = bodyData.data(using: .utf8)
                    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
        }}
            static func deleteTask(id: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
                if let urlToReq = URL(string: "http://127.0.0.1:8080/tasks/\(id)"){
                var request = URLRequest(url: urlToReq)
                    request.httpMethod = "DELETE"
                
                    let bodyData = "id=\(id)"
                    request.httpBody = bodyData.data(using: .utf8)
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }}
}
