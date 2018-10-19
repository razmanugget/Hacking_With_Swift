//
//  ViewController.swift
//  Swifty Words
//
//  Created by home on 11/22/17.
//  Copyright © 2017 lyfebug. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
	var letterButtons = [UIButton]()
	var activatedButtons = [UIButton]()
	var solutions = [String]()
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	var level = 1
	
	@IBOutlet weak var cluesLabel: UILabel!
	@IBOutlet weak var answersLabel: UILabel!
	@IBOutlet weak var currentAnswer: UITextField!
	@IBOutlet weak var scoreLabel: UILabel!
	
	@IBAction func submitTapped(_ sender: Any) {
		if let solutionPosition = solutions.index(of: currentAnswer.text!) {
			activatedButtons.removeAll()
			
			var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
			splitAnswers[solutionPosition] = currentAnswer.text!
			answersLabel.text = splitAnswers.joined(separator: "\n")
			
			currentAnswer.text = ""
			score += 1
			if score % 7 == 0 {
				let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
				present(ac, animated: true)
			}
		}
	}
	
	@IBAction func clearTapped(_ sender: Any) {
		currentAnswer.text = ""
		
		for btn in activatedButtons {
			btn.isHidden = false
		}
		activatedButtons.removeAll()
	}
	
	func loadLevel() {
		var clueString = ""
		var solutionString = ""
		var letterBits = [String]()
		
		// loading the level string from the file
		if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
			if let levelContents = try? String(contentsOfFile: levelFilePath) {
				var lines = levelContents.components(separatedBy: "\n")
				lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
				
				// says where each item is in the array to make the clue string
				for (index, line) in lines.enumerated() {
					let parts = line.components(separatedBy: ": ")
					let answer = parts[0]
					let clue = parts[1]
					
					clueString += "\(index + 1). \(clue)\n"
					
					let solutionWord = answer.replacingOccurrences(of: "|", with: "")
					solutionString += "\(solutionWord.count) letters\n"
					solutions.append(solutionWord)
					
					let bits = answer.components(separatedBy: "|")
					letterBits += bits
				}
			}
		}
		// trim out the line breaks and white space
		cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
		answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
		letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
		
		if letterBits.count == letterButtons.count {
			for i in 0 ..< letterBits.count {
				letterButtons[i].setTitle(letterBits[i], for: .normal)
			}
		}
	}
	
	func levelUp(action: UIAlertAction) {
		level += 1
		solutions.removeAll(keepingCapacity: true)
		
		loadLevel()
		
		for btn in letterButtons {
			btn.isHidden = false
		}
	}
	
	@objc func letterTapped(btn: UIButton) {
		currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
		activatedButtons.append(btn)
		btn.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// looping through view.subviews array to add button text
		for subview in view.subviews where subview.tag == 1001 {
			let btn = subview as! UIButton
			letterButtons.append(btn)
			// addTarget to attach a method to button click
			btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
		}
		loadLevel()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

