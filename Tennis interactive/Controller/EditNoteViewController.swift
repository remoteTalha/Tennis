//
//  EditNoteViewController.swift
//  Tennis interactive
//
//  Created by Anish on 10/15/22.
//

import UIKit

class EditNoteViewController: UIViewController {

    
     @IBOutlet weak var titleField: UITextField!
     @IBOutlet weak var desc: UITextView!
     
     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
     }
     

     @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true)
     }
     
     @IBAction func cancel(_ sender: Any) {
         self.dismiss(animated: true)
     }
     @IBAction func addNote(_ sender: Any) {
     }

}
