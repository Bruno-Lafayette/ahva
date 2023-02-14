import Foundation

class HTTPRequestFactory {
    private var path: String
    private var method: HTTPMethod
    private var parameters: [String:Any] = [:]
    private var headers: [String:Any] = [:]
    private var timeoutInterval: Double
    private var body: Data?
    
    public init(path: String, method: HTTPMethod, body: Data? = nil, timeoutInterval: Double = 15, parameters: [String:[Any]] = [:], headers: [String:Any] = [:]) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.timeoutInterval = timeoutInterval
        self.body = body
    }
    
    //recebe os parametros
    private func buildParameters() -> String {
        var params: String = ""
        
        for key in self.parameters.keys {
            guard let value = parameters[key] else { continue }
            params += (params.isEmpty) ? "?\(key)=\(value)" : "&\(key)=\(value)"
        }
        
        return params
    }
    
    //constroi a url
    private func buildURL() throws -> URL {
        var domain = self.path
        
        if !self.parameters.isEmpty {
            domain += buildParameters()
        }
        
        guard let url = URL(string: domain) else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    //cria a requisição
    func createRequest() throws -> HTTPRequest {
        let url = try buildURL()
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if !self.headers.isEmpty {
            for key in self.headers.keys {
                guard let value = self.headers[key] else { continue }
                request.addValue("\(value)", forHTTPHeaderField: key)
            }
        }
        
        if let body {
            request.httpBody = body
        }
        
        request.timeoutInterval = self.timeoutInterval
        return HTTPRequest(request: request)
    }
}

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}
