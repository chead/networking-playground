import Foundation

let url        = URL(string: "https://foo.bar")!
var request    = URLRequest(url: url)

request.httpMethod          = "GET"
request.allHTTPHeaderFields = [:]

URLSession.shared.dataTask(with: request) { (data, response, error) in
    switch(data, response, error) {
    
    // data is unbound, may be nil
    // response is unbound, may be nil
    // error is bound to a variable and must not be nil
    case (_, _, let error?):
        print("Error: \(error.localizedDescription)")

    // data is bound to a variable and must not be nil
    // response is unbound but must be castable to HTTPURLResponse
    // error must be nil
    case (let data?, _ as HTTPURLResponse, nil):
        print("Response: \(String(describing: data))")

    // 🤷‍♂️
    default:
        break
    }
}
