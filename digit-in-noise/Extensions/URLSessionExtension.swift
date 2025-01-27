//
//  URLSessionExtension.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

import Foundation

enum CustomError: String, Error {
    case invalidResponse
    case invalidRequest
    case invalidUrl
    case invalidData
    case internalError
    case parsingError
}

extension URLSession {
    
    func makeRequest<Generic: Codable, BodyModel: Codable>(
        url: String,
        rersponseModel: Generic.Type,
        requestBody: BodyModel? = nil,
        completion: @escaping (Result<Generic, CustomError>) -> Void) {
            
            guard let endpointUrl = (URL(string: url)) else {
                completion(.failure(.invalidUrl))
                return
            }
            var request = URLRequest(url: endpointUrl)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Step 3: Encode the model into JSON
            do {
                let jsonData = try JSONEncoder().encode(requestBody)
                request.httpBody = jsonData
            } catch {
                completion(.failure(.parsingError))
                return
            }
            
            
            logRequest(request)
            self.callRequest(with: request, model: rersponseModel, completion: completion)
        }
    
    private func callRequest<Generic: Codable>(
        with request: URLRequest,
        model: Generic.Type,
        completion: @escaping (Result<Generic, CustomError>) -> Void) {
            let apiTask = self.dataTask(with: request) { data, response, error in
                self.logResponse(response, data: data, error: error)
                guard let safeData = data else {
                    if error != nil {
                        DispatchQueue.main.async { completion(.failure(.invalidData)) }
                    } else {
                        DispatchQueue.main.async { completion(.failure(.internalError)) }
                    }
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(model, from: safeData)
                    DispatchQueue.main.async { completion(.success(result)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(.parsingError)) }
                }
            }
            apiTask.resume()
        }
    
    private func logRequest(_ request: URLRequest) {
        print("--------------------")
        print("Request:")
        print("URL: \(request.url?.absoluteString ?? "No URL")")
        print("HTTP Method: \(request.httpMethod ?? "No HTTP Method")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        print("--------------------")
    }
    
    private func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        print("--------------------")
        print("Response:")
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            print("Headers: \(httpResponse.allHeaderFields)")
        }
        if let error = error {
            print("Error: \(error.localizedDescription)")
        }
        if let data = data, let responseBody = String(data: data, encoding: .utf8) {
            print("Body: \(responseBody)")
        }
        print("--------------------")
    }
}
