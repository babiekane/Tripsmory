import UIKit

let numbers = [1, 5, 2, 5, 3, 5]

var count = 0
for number in numbers {
  if number == 5 {
    count += 1
  }
}
print(count)
