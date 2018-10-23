/*:
 ## Exercise - Adopt Protocols: CustomStringConvertible, Equatable, and Comparable
 
 Create a `Human` class with two properties: `name` of type `String`, and `age` of type `Int`. You'll need to create a memberwise initializer for the class. Initialize two `Human` instances.
 */

class Human: CustomStringConvertible, Equatable, Comparable, Codable {
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
    
    static func == (lhs: Human, rhs: Human) -> Bool {
        return lhs.age == rhs.age && lhs.name == rhs.name
    }
    
    var description: String
    
    var name: String
    var age: Int
    
    init(name: String, age: Int, description: String) {
        self.name = name
        self.age = age
        self.description = description
    }
}
/*:
 Make the `Human` class adopt the `CustomStringConvertible`. Print both of your previously initialized `Human` objects.
 */
var h1 = Human(name: "Justin", age: 4, description: "hey dude")
var h2 = Human(name: "Justin", age: 7, description: "hey dudes")
print(h1)
print(h2)
/*:
 Make the `Human` class adopt the `Equatable` protocol. Two instances of `Human` should be considered equal if their names and ages are identical to one another. Print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are equal to eachother (using `==`). Then print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are not equal to eachother (using `!=`).
 */
print(h1 == h2)
print(h1 != h2)
/*:
 Make the `Human` class adopt the `Comparable` protocol. Sorting should be based on age. Create another three instances of a `Human`, then create an array called `people` of type `[Human]` with all of the `Human` objects that you have initialized. Create a new array called `sortedPeople` of type `[Human]` that is the `people` array sorted by age.
 */
var people: [Human] = [Human(name: "Foo", age: 199, description: "hey"), Human(name: "dude", age: 2, description: "reeeee"), Human(name: "mood", age: 28, description: "supaaaaaa")]
var sortedPeople: [Human] = people.sorted(by: <)

/*:
 Make the `Human` class adopt the `Codable` protocol. Create a `JSONEncoder` and use it to encode as data one of the `Human` objects you have initialized. Then use that `Data` object to initialize a `String` representing the data that is stored, and print it to the console.
 */
import Foundation

let myjson = JSONEncoder()
if let jsonData = try? myjson.encode(h1), let jsonString = String(data: jsonData, encoding: .utf8) {
    print(jsonString)
}
//: page 1 of 5  |  [Next: App Exercise - Printable Workouts](@next)
