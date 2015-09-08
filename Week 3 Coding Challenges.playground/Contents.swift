//Week 3 coding challenges by (Matthew) Sau Chung Loh

import UIKit
//Monday
//Code Challenge: Write a function that takes in an array of numbers, and returns the lowest and highest numbers as a tuple

func returnMinAndMax(array : [Int]) -> (minimum: Int, maximum: Int) {
  var min: Int = array[0]
  var max: Int = array[0]
  
  for num in array {
    if num < min {
      min = num
    }
    if num > max {
      max = num
    }
  }
  return (min, max)
}

let array1 = [1, 2 ,3 ,4 ,5]
let array2 = [87, 23, 49, 29]
returnMinAndMax(array1)
returnMinAndMax(array2)

//Tuesday
//Code Challenge: Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3.

func returnMiddleThree(array : [Int]) -> [Int]? {
  var middleThree = [Int]()
  if array.count <= 3 && array.count % 2 == 0 {
    println("Array's length must be greater than three and odd")
    return nil
  } else {
    var middleIndex = array.count / 2
    middleThree.append(array[middleIndex - 1])
    middleThree.append(array[middleIndex])
    middleThree.append(array[middleIndex + 1])
    return middleThree
  }
}

let array3 = [1, 2, 3, 4 ,5 ,6 ,7]
let array4 = [84, 43 ,435, 5342, 54, 54, 456, 34525, 754]
returnMiddleThree(array3)
returnMiddleThree(array4)

//Wednesday
//Code Challenge: Given a non-negative number "num", return true if num is within 2 of a multiple of 10. Note: (a % b) is the remainder of dividing a by b, so (7 % 5) is 2

func withinTwo(num : Int) -> Bool {
  if num % 10 == 0 {
    return true
  }
  if num < 10 {
    return 10 - num <= 2 ? true : false
  }
  if num % 10 > 2 && num % 10 < 8 {
    return false
  } else {
    return true
  }
}

withinTwo(10)
withinTwo(12)
withinTwo(13)
withinTwo(17)
withinTwo(19)
withinTwo(18)
withinTwo(7)
withinTwo(8)
withinTwo(103)

//Thursday
//Code Challenge: Given a string, return a string where for every char in the original, there are two chars.
//Example: doubleChar("The") → "TThhee"

func doubleChar (word : String) -> String {
  var doubleString = ""
  for char in word {
    doubleString += "\(char)" + "\(char)"
  }
  return doubleString
}

doubleChar("Cat")
doubleChar("Tyrannasaurusrex")
