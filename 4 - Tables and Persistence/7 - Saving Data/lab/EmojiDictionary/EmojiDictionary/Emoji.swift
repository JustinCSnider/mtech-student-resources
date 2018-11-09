
import Foundation

struct Emoji: Codable {
    var symbol: String
    var name: String
    var detailDescription: String
    var usage: String
    
    static func saveToFIle(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
        
        let encodedEmojis = try? propertyListEncoder.encode(emojis)
        
        try? encodedEmojis?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Emoji]? {
        let propertyListDecoder = PropertyListDecoder()
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = DocumentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
        
        if let retrievedEmojiData = try? Data(contentsOf: archiveURL), let decodedEmojis = try? propertyListDecoder.decode(Array<Emoji>.self, from: retrievedEmojiData) {
            return decodedEmojis
        }
        
        return nil
    }
    
    
}
