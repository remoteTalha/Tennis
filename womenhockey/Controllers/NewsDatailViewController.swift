//
//  NewsDatailViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/09/2022.
//

import UIKit
import WebKit
class NewsDatailViewController: UIViewController {
    
 
  
    @IBOutlet weak var myWebView: WKWebView!
    
      var webUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: self.webUrl) {
            self.myWebView.load(URLRequest(url: url))
        }
       
    }

  
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
