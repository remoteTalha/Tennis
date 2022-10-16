//
//  AddNewNoteVC.swift
//  Tennis interactive
//
//  Created by Anish on 10/15/22.
//

import UIKit
protocol NotesSaved {
    func noteCreated(notes:[String])
}

class AddNewNoteVC: UIViewController {

   
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var desc: UITextView!
    
    var notes = [String]()
    var createNotesDelegate : NotesSaved? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let note = UserDefaults.standard.object(forKey: "Notes") {
            self.notes = note as! Array
        }
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
            self.createNotesDelegate?.noteCreated(notes: self.notes)
            self.dismiss(animated: true)
        }
    }
    
}
