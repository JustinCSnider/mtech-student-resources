/*:
 ## App Exercise - Fitness Calculations
 
 >These exercises reinforce Swift concepts in the context of a fitness tracking app.
 
 Your fitness tracker keeps track of users' heart rate, but you might also want to display their average heart rate over the last hour. Create three constants, `heartRate1`, `heartRate2`, and `heartRate3`. Give each constant a different value between 60 and 100. Create a constant `addedHR` equal to the sum of all three heart rates. Now create a constant called `averageHR` that equals `addedHR` divided by 3 to get the average. Print the result.
 */
var hr1 = 73
var hr2 = 91
var hr3 = 66
var addedHR = hr1 + hr2 + hr3
var avgHR = addedHR / 3

print(avgHR)
/*:
 Now create three more constants, `heartRate1D`, `heartRate2D`, and `heartRate3D`, equal to the same values as `heartRate1`, `heartRate2`, and `heartRate3`. These new constants should be of type `Double`. Create a constant `addedHRD` equal to the sum of all three heart rates. Create a constant called `averageHRD` that equals the `addedHRD` divided by 3 to get the average of your new heart rate constants. Print the result. Does this differ from your previous average? Why or why not?
 */
var hr1D = Double(hr1)
var hr2D = Double(hr2)
var hr3D = Double(hr3)
var addedHRD = hr1D + hr2D + hr3D
var avgHRD = addedHRD / 3

print(avgHRD) // The result from this equation versus the result of the last equation should be that the equation that used the doubles should have a more precise result because it is giving an average down to the decimal instead of a rounded version of the average heart rate.
/*:
 Imagine that partway through the day a user has taken 3,467 steps out of the 10,000 step goal. Create constants `steps` and `goal`. Both will need to be of type `Double` so that you can perform accurate calculations. `steps` should be assigned the value 3,467, and `goal` should be assigned 10,000. Create a constant `percentOfGoal` that equals an expression that evaluates to the percent of the goal that has been achieved so far.
 */
let steps = 3_467.0
let goal = 10_000.0
let percentOfGoal = steps / goal

print(percentOfGoal)
//: [Previous](@previous)  |  page 2 of 8  |  [Next: Exercise - Compound Assignment](@next)
