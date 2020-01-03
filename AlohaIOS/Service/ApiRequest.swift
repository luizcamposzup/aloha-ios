//
//  ApiRequest.swift
//  AlohaIOS
//
//  Created by zupper on 01/01/20.
//  Copyright © 2020 Luizhcarminati. All rights reserved.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct ApiRequest {
    static var defaultRequest = ApiRequest()
    
    var setConfiguration: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 180.0
        sessionConfig.timeoutIntervalForResource = 60.0
        return URLSession(configuration: sessionConfig)
    }
    
    func getListZuppers (completion: @escaping(Result<ZupperContentResponse, APIError>) -> Void) {
        do {
            let url = "https://aloha-backend-dev.continuousplatform.com/customer"
            guard let resourceURL = URL(string: url) else {fatalError()}
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = setConfiguration.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let notificationData = try JSONDecoder().decode(ZupperContentResponse.self, from: jsonData)
                    completion(.success(notificationData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getListVisitors (completion: @escaping(Result<[Visitor], APIError>) -> Void) {
        do {
            let url = "https://aloha-backend-dev.continuousplatform.com/api/zup-aloha/all"
            
            guard let resourceURL = URL(string: url) else {fatalError()}
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = setConfiguration.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let getVisitorData = try JSONDecoder().decode([Visitor].self, from: jsonData)
                    completion(.success(getVisitorData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func registerVisitorRequest (_ visitorForRegister: Visitor,
                       completion: @escaping(Result<Visitor, APIError>) -> Void) {
        do {
            let url = "https://aloha-backend-dev.continuousplatform.com/api/zup-aloha/people"
            
            guard let resourceURL = URL(string: url) else {fatalError()}
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(visitorForRegister)

            let dataTask = setConfiguration.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let registerData = try JSONDecoder().decode(Visitor.self, from: jsonData)
                    completion(.success(registerData))
//                    DispatchQueue.main.async {
//
//                    }
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func notificationRequest (_ emailForNotification: NotificationRequest,
                       completion: @escaping(Result<NotificationResponse, APIError>) -> Void) {
        do {
            let url = "https://aloha-backend-dev.continuousplatform.com/message"
            guard let resourceURL = URL(string: url) else {fatalError()}
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(emailForNotification)

            let dataTask = setConfiguration.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let notificationData = try JSONDecoder().decode(NotificationResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(notificationData))
                    }
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}
