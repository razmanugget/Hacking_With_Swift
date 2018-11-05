//: Playground - noun: a place where people can play

import UIKit

// EXTENSIONS
// Extension - with an Int
// ----------------------------------------------------------------------------
extension Int {
  func plusOne() -> Int {
    return self + 1
  }
  
  mutating func mutatePlusOne() {
    self += 1
  }}

// in this case, the original is not modified
var myInt = 5
myInt.plusOne()           // o: 6
myInt                     // o: 5

// same here
5.plusOne()               // o: 6

// using a mutating extension to modify the original
var myInt2 = 8
myInt2.mutatePlusOne()
myInt2


// ** Simple PROTOCOL-based programming
// ----------------------------------------------------------------------------
extension Int {
  func squared() -> Int {
    // self works with **current values**
    return self * self
  }}

// BinaryInteger is the protocol applied to Int, Int8, UInt64...)
extension BinaryInteger {
  // Self (cap) is working with all data types (Int, Int8, UInt64...)
  func squared2() -> Self {
    return self * self
  }}

var numInt: Int = 8
print(numInt.squared())                 // o: 64

var numInt2: UInt8 = 8
print(numInt.squared2())                // o: 64 works with Int
print(numInt2.squared2())               // o: 64 works with UInt8


// computed property vs method extensions
extension String {
  // computed property
  var trimmed: String {
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  // method
  mutating func trim() {
    self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
}
