

/*:
 Now assume you go through and remove friends that aren't active on social media. Update your `friends` constant to a lower number than it currently is.
 */
let friends: Int
friends = 540

// This would not work since it is trying to change the initial value of the constant.
// friends = 473
/*:
 Does the above code compile? Why not? Print your explanation to the console using the `print` function. Go back and delete your line of code that updates the `friend` constant to a lower number so that the playground will compile properly.
 */
print("No it does not. Because I am making 'friends' a constant, it became immutable which means it cannot be changed.")

//: page 1 of 10  |  [Next: App Exercise - Step Goal](@next)
