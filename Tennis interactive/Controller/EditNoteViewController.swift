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
     var note = [String]()
     var index = 0
     var editNotesDelegate : NotesSaved? = nil
    
     override func viewDidLoad() {
         super.viewDidLoad()

         let note = self.note[index]
         let sepr = note.components(separatedBy: "space")
         self.titleField.text = sepr[0]
         self.desc.text = sepr[1]
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
             self.note[index] = note
             UserDefaults.standard.set(self.note, forKey: "Notes")
             self.editNotesDelegate?.noteCreated(notes: self.note)
             self.dismiss(animated: true)
         }
     }

}
