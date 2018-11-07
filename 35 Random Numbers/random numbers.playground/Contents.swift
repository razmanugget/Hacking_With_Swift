//: Playground - noun: a place where people can play

import UIKit
import GameplayKit

// Randomness
// these don't require GameplayKit
// ----------------------------------------------------------------------------
print(arc4random())

print(arc4random_uniform(6))

// using GameplayKit -> much more random, but not enough for cryptokeys
print(GKRandomSource.sharedRandom().nextInt(upperBound: 3))

// options with GameplayKit
// ----------------------------------------------------------------------------
// high performance, lowest randomness
let congruential = GKLinearCongruentialRandomSource()
congruential.nextInt(upperBound: 20)

// high randomness, lowest performance
let mersenne = GKMersenneTwisterRandomSource()
mersenne.nextInt(upperBound: 20)

// goldilocks of randomnesss
let arc4 = GKARC4RandomSource()
arc4.dropValues(1024)        // use to avoid guessable sequences (any)
arc4.nextInt(upperBound: 20)

// Random distributions
// creating a source for random distribution
// ----------------------------------------------------------------------------
let rand = GKMersenneTwisterRandomSource()
let distribution = GKRandomDistribution(randomSource: rand, lowestValue: 10, highestValue: 20)
print(distribution.nextInt())

// distribution with no repeats (go thru the entire sequence once)
// ----------------------------------------------------------------------------
let noRepeatDist = GKShuffledDistribution(randomSource: rand, lowestValue: 10, highestValue: 20)
print(noRepeatDist.nextInt())

// distribution forms a natural bell curve (more in middle)
// ----------------------------------------------------------------------------
let gaussianDist = GKGaussianDistribution(randomSource: rand, lowestValue: 10, highestValue: 20)
print(gaussianDist.nextInt())


