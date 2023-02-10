//
//  HTTPRequest.swift
//  ahva
//
//  Created by Well on 07/02/23.
//

import Foundation

class HTTPRequest {
    
    var request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func send() async throws -> (body: Data?, response: HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: self.request)
        let convertedResponse = response as! HTTPURLResponse
        return (data, convertedResponse)
    }
}

