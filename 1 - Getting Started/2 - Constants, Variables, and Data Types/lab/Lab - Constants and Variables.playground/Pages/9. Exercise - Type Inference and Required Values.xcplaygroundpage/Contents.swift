/*:
 ## Exercise - Type Inference and Required Values
 
 Declare a variable called `name` of type `String`, but do not give it a value. Print `name` to the console. Does the code compile? Remove any code that will not compile.
 */
var name: String
// print(name)
// It does not compile.
/*:
 Now assign a value to `name`, and print it to the console.
 */
name = "I want to eat some pizza."
print(name)
/*:
 Declare a variable called `distanceTraveled` and set it to 0. Do not give it an explicit type.
 */
var distanceTraveled: Double = 0.0
// I had to add .0 to the initial value of 0 so that distanceTraveled would initialize as a double. Adding ': Double' is unneccessary but I added it anyways.
/*:
 Now assign a value of 54.3 to `distanceTraveled`. Does the code compile? Go back and set an explicit type on `distanceTraveled` so the code will compile.
 */
distanceTraveled = 54.3 // This did not initially compile, until I made the variable implicitly a double.

//: [Previous](@previous)  |  page 9 of 10  |  [Next: App Exercise - Percent Completed](@next)
