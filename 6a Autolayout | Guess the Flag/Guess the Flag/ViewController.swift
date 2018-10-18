//
//  ViewController.swift
//  Guess the Flag
//
//  Created by home on 11/10/17.
//  Copyright © 2017 lyfebug. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {

	var countries = [String]()
	var correctAnswer = 0
	var score = 0
	
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else  {
			title = "Wrong"
			score -= 1
		}
		
		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}
	
	
	func askQuestion(action: UIAlertAction!) {
		// randomize the order of the array with GameplayKit
		countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]

		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
		title = countries[correctAnswer].uppercased()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		
		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1
		button1.layer.borderColor = UIColor.lightGray.cgColor
		button2.layer.borderColor = UIColor.lightGray.cgColor
		// specifying the color directly
		button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor  // orange color
		
		askQuestion(action: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

