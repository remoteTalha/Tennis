//
//  AddNewNoteVC.swift
//  Tennis interactive
//
//  Created by Anish on 10/15/22.
//

import UIKit

class AddNewNoteVC: UIViewController {

   
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var desc: UITextView!
    
    var notes = [String]()
    
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
        if titleField.text == "" || desc.text == "" {
            simpleAlert("Enter title and description")
        }else {
            let note = "\(self.titleField.text!)space\(self.desc.text!)"
            self.notes.append(note)
            UserDefaults.standard.set(self.notes, forKey: "Notes")
            self.dismiss(animated: true)
        }
    }
    
}
