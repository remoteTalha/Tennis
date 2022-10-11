//
//  NotesViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/09/2022.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var notesView: UIView!
    
    @IBOutlet weak var readNotesView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var readNoteLbl: UILabel!
    @IBOutlet weak var notestitle: UITextField!
    @IBOutlet weak var readNoteTxt: UILabel!
    
    
    
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesView.isHidden = true
        self.readNotesView.isHidden = true
        
        if let note = UserDefaults.standard.object(forKey: "notes") {
            self.notes = note as! Array
        }
    }
    
    @IBAction func closeNotes(_ sender: Any) {
        self.readNotesView.isHidden = true
    }
    @IBAction func addNotesTapped(_ sender: UIButton) {
        self.notesView.isHidden = false
    }
    @IBAction func addNotes(_ sender: Any) {
        let alert = UIAlertController(title: APP_NAME, message: "Save notes", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default) { action in
            self.notes.append("\(self.notestitle.text ?? "No title")T\(self.notesText.text ?? "No text")")
            UserDefaults.standard.set(self.notes, forKey: "notes")
            self.notesView.isHidden = true
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.notesView.isHidden = true
        }
        alert.addAction(save)
        alert.addAction(cancel)
        self.present(alert, animated: true)
       
    }
    
}

extension NotesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesCell
        let getTitle = notes[indexPath.row].components(separatedBy: "T")
        cell.notesTitle.text = getTitle[0]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = notes[indexPath.row]
        let getTitle = data.components(separatedBy: "T")
        self.readNoteLbl.text = getTitle[0]
        self.readNoteTxt.text = getTitle[1]
        self.readNotesView.isHidden = false
    }
}
