import Foundation

extension URLSessionDataTask {
    enum Error: Swift.Error {
        case unknown
    }
}
extension URLSession {
    func dataTask<Value: Decodable>(with request: URLRequest, completionHandler: @escaping (Result<Value,  Error>) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { (data, response, error) in
            return completionHandler({ () -> Result<Value,  Error> in
                switch(data, response, error) {
                case (let data?, _ as HTTPURLResponse, nil):
                    do               { return .success(try JSONDecoder().decode(Value.self, from: data)) }
                    catch(let error) { return .failure(error) }
                    
                case (_, _, let error):
                    return .failure(error ?? URLSessionDataTask.Error.unknown)
                }
            } ())
        }
    }
}

struct MyAPIType: Decodable {
    let i: Int
}

let url     = URL(string: "https://foo.bar")!
var request = URLRequest(url: url)

request.httpMethod          = "GET"
request.allHTTPHeaderFields = [:]

URLSession.shared.dataTask(with: request) { (result: Result<MyAPIType, Error>) in
    switch result {
    case .success(let value): break
    case .failure(let error): break
    }
}
