/*:
 ## Exercise - Types and Type Safety
 
 Declare two variables, one called `firstDecimal` and one called `secondDecimal`. Both should have decimal values. Look at both of their types by holding Option and clicking on the variable name.
 */
var firstDecimal = 3.14159265358979323846264338328
var secondDecimal = 12.6
/*:
 Declare a variable called `trueOrFalse` and give it a boolean value. Try to assign it to `firstDecimal` like so: `firstDecimal = trueOrFalse`. Does it compile? Print a statement to the console explaining why not, and remove the line of code that will not compile.
 */
var trueOrFalse = true
// firstDecimal = trueOrFalse
// Trying to set a double equal to a boolean value creates a compiling error because you cannot implicitly convert a bool to a double.
/*:
 Declare a variable and give it a string value. Then try to assign it to `firstDecimal`. Does it compile? Print a statement to the console explaining why not, and remove the line of code that will not compile.
 */
var wordValue = "Pizza is good."
// firstDecimal = wordValue
// Like the last problem, if something is declared as a certain object type, then it does not like it when you try to set that object equal to a different object type i.e. string to double.
/*:
 Finally, declare a variable with a whole number value. Then try to assign it to `firstDecimal`. Why won't this compile even though both variables are numbers? Print a statement to the console explaining why not, and remove the line of code that will not compile.
 */
var thisIsAnInt = 4
// firstDecimal = thisIsAnInt
// Even if both of the object types contain numbers (integers and doubles), you cannot set a double equal to an int or vice versa. You need to convert one to the other first.
//: [Previous](@previous)  |  page 7 of 10  |  [Next: App Exercise - Tracking Different Types](@next)
