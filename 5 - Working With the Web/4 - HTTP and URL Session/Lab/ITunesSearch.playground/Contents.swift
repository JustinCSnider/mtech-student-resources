import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String : String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)

        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let baseURL = URL(string: "https://itunes.apple.com/search?")!

let query: [String : String] = [
    "term" : "Shrek",
    "media" : "movie",
    "lang" : "en_us",
    "limit" : "1"
]

let url = baseURL.withQueries(query)!
URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data, let string = String(data: data, encoding: .utf8){
        print(string)
        PlaygroundPage.current.finishExecution()
    }
}.resume()

