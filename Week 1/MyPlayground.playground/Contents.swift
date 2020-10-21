//Exercise 1
for i in 1...20{
    print(i)
}


//Exercise 2
for i in 1...20{
    if i&1 == 1{
        print(i)
    }
}


//Exercise 3
var res = 0
for i in 1...20{
    if i&1 == 1{
        res += i
    }
}
print(res)


//Example 2
// Declare instance function
func sayIt(aNumber: Int) {
    print("You pass a " + String(aNumber))
}

sayIt(aNumber:5)


// Exercise 4
func result(mark : Int)-> String{
    return mark >= 40 ? "Pass" : "Fail"
}

print(result(mark: 50))


// Exercise 5
import Foundation

var arr = [Int]()

for _ in 1...10{
    let x = Int(arc4random_uniform(100))
    arr.append(x)
}

func findMax(n: [Int])->Int{
    var highest = Int.min
    for val in n{
        highest = max(highest, val)
    }

    return highest
}

print(findMax(n: arr))

// Exercise 6
func findMin(n: [Int])->Int{
    var lowest = Int.max
    for val in n{
        lowest = min(lowest, val)
    }

    return lowest
}

print(findMin(n: arr))

// Exercise 7
func findAverage(n: [Int])->Double{
    var s = 0;
    for val in n{
        s += val
    }

    return Double(s) / Double(n.count)
}

print(findAverage(n: arr))
