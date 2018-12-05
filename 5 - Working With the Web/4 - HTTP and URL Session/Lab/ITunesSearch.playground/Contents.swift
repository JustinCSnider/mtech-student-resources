//import UIKit
//import PlaygroundSupport
//
//PlaygroundPage.current.needsIndefiniteExecution = true
//
//extension URL {
//    func withQueries(_ queries: [String : String]) -> URL? {
//        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
//
//        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
//        return components?.url
//    }
//}
//
//let baseURL = URL(string: "https://itunes.apple.com/search?")!
//
//let query: [String : String] = [
//    "term" : "Shrek",
//    "media" : "movie",
//    "lang" : "en_us",
//    "limit" : "1"
//]
//
//let url = baseURL.withQueries(query)!
//URLSession.shared.dataTask(with: url) { (data, response, error) in
//    if let data = data, let string = String(data: data, encoding: .utf8){
//        print(string)
//        PlaygroundPage.current.finishExecution()
//    }
//}.resume()


import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var json: Data = {
    let jsonDictionary = ["report_date": "2018-01-20",
                          "profile_id": "136442",
                          "name": "Final Results for Q4 2017",
                          "read_count": "5"]
    
    return try! JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
}()

struct Report: Decodable {
    let name: String
    let creationDate: String
    let profileID: String
    let readCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case creationDate = "report_date"
        case profileID = "profile_id"
        case readCount = "read_count"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: Report.CodingKeys.self)
        self.creationDate = try valueContainer.decode(String.self, forKey: CodingKeys.creationDate)
        self.profileID = try valueContainer.decode(String.self, forKey: CodingKeys.profileID)
        let readCountString = try? valueContainer.decode(String.self, forKey: CodingKeys.readCount)
        if let readCountString = readCountString {
            self.readCount = Int(readCountString)
        } else {
            self.readCount = nil
        }
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
    }
}

func getData(completion: @escaping (Data?) -> Void) {
    completion(json)
}

getData { data in
    let jsonDecoder = JSONDecoder()
    if let data = data,
        let report = try? jsonDecoder.decode(Report.self, from: data) {
        print(report)
    }
}
