/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */

var collection: [Any] = [2.3, 3.2, 2, 4, "20", "rue", true, false]
print(collection)
/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */

for i in collection {
    if i is Int {
        print(i)
    } else if i is String {
        print(i)
    } else if i is Double {
        print(i)
    } else if i is Bool {
        print(i)
    }
}
/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
var collections: [String: Any] = ["Dude": 3.2, "Guy": 2, "Foo": "Bar", "Bool": true]

for i in collections {
    print(i.value)
}
/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */

var total: Double = 0
for i in collections.values {
    if let unwrappedValue =  i as? Int {
        total += Double(unwrappedValue)
    } else if let unwrappedValue = i as? Double {
        total += unwrappedValue
    } else if i is String {
        total += 1
    } else if let unwrappedValue = i as? Bool {
        total += unwrappedValue ? 2 : -3
    }
}

print(total)
/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */

var total2: Double = 0

for i in collection {
    if let unwrappedValue =  i as? Int {
        total2 += Double(unwrappedValue)
    } else if let unwrappedValue = i as? Double {
        total2 += unwrappedValue
    } else if let unwrappedValue = i as? String {
        if let unwrappedString = Double(unwrappedValue) {
            total2 += unwrappedString
        }
    }
}

print(total2)
//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
