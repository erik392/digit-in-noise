//
//  UploadResultsRepository.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

import Foundation

typealias UploadTestResultsResult = (Result<TestResultsModel, CustomError>) -> Void

protocol UploadResultsRepositoryType: AnyObject {
    func sendResults(results: TestResultsModel, completion: @escaping(UploadTestResultsResult))
}

class UploadResultsRepository: UploadResultsRepositoryType {
    
    func sendResults(results: TestResultsModel,
                     completion: @escaping(UploadTestResultsResult)) {
        URLSession.shared.makeRequest(url: "https://enoqczf2j2pbadx.m.pipedream.net",
                                      rersponseModel: TestResultsModel.self,
                                      requestBody: results,
                                      completion: completion)
        
    }
}

