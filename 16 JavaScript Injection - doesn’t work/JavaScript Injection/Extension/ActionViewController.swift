//
//  ActionViewController.swift
//  Extension
//
//  Created by home on 5/21/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
      if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
        if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
          // closure is used to execute asynchronously while the item is busy loading/sending data
          // unowned self -> used to avoid strong reference cycles
          itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [unowned self] (dict, error) in
            let itemDictionary = dict as! NSDictionary
            let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
            print(javaScriptValues)
          }
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
