//
//  DetailViewController.swift
//  GitHub Commits
//
//  Created by home on 7/2/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var detailItem: Commit?
  
  @IBOutlet var detailLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let detail = self.detailItem {
      detailLabel.text = detail.message
      // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1/\(detail.author.commits.count)", style: .plain, target: self, action: #selector(showAuthorCommits))
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
