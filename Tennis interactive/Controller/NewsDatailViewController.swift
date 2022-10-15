//
//  NewsDatailViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/09/2022.
//

import UIKit
import WebKit
class NewsDatailViewController: UIViewController {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDetail: UITextView!
    
    var selectedNews:News? = nil
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: self.selectedNews!.image) {
            self.newsImage.sd_setImage(with: url)
        }
        self.newsDetail.text = selectedNews?.excerpt
       
    }

  
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
