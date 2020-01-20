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
    case requestProblem
}

struct ApiRequest {
    static var defaultRequest = ApiRequest()
    let baseUrl = "aloha-backend-dev.continuousplatform.com"
    
    var setConfiguration: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 180.0
        sessionConfig.timeoutIntervalForResource = 60.0
        return URLSession(configuration: sessionConfig)
    }
    
    func getZupper(emailOrNameToSearch: String, sizeRequest: String, completion: @escaping(Result<ZupperContentResponse, APIError>) -> Void) {
        do {
            var components = URLComponents()
            components.scheme = "https"
            components.host = self.baseUrl
            components.path = "/customer"
            components.queryItems = [
                URLQueryItem(name: "nameOrEmail", value: emailOrNameToSearch),
                URLQueryItem(name: "size", value: sizeRequest)
            ]
            guard let url = components.url else {
                completion(.failure(.requestProblem))
                return
            }
            let dataTask = setConfiguration.dataTask(with: url) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let zupperData = try JSONDecoder().decode(ZupperContentResponse.self, from: jsonData)
                    completion(.success(zupperData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getVisitor(emailVisitorToSearch: String, completion: @escaping(Result<VisitorResponse, APIError>) -> Void) {
        do {
            var components = URLComponents()
            components.scheme = "https"
            components.host = self.baseUrl
            components.path = "/api/zup-aloha/email"
            components.queryItems = [URLQueryItem(name: "email", value: emailVisitorToSearch)]
            guard let url = components.url else {
                completion(.failure(.requestProblem))
                return
            }
            let dataTask = setConfiguration.dataTask(with: url) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let visitorData = try JSONDecoder().decode(VisitorResponse.self, from: jsonData)
                    completion(.success(visitorData))
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
            let url = "\(self.baseUrl)/api/zup-aloha/people"
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
                    print("responseProblem")
                    return
                }
                do {
                    let notificationData = try JSONDecoder().decode(NotificationResponse.self, from: jsonData)
                    completion(.success(notificationData))
                    print("notificationData")
                } catch {
                    completion(.failure(.decodingProblem))
                    print("decodingProblem")
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
            print("encodingProblem")
        }
    }
}
