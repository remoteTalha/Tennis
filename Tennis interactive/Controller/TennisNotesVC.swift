//
//  TennisNotesVC.swift
//  TennisInteractive
//
//  Created by Anish on 10/12/22.
//

import UIKit

class TennisNotesVC: UIViewController ,NotesSaved{
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = UserDefaults.standard.object(forKey: "Notes") {
            self.notes = note as! Array
        }
    }
    //delegate for backward data handling
    func noteCreated(notes:[String]) {
        self.notes = notes
        self.tableView.reloadData()
    }
    @IBAction func addNotes(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewNoteVC") as! AddNewNoteVC
        vc.createNotesDelegate = self
        self.present(vc, animated: true)
    }
    


}
extension TennisNotesVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotesableViewCell
        let note = self.notes[indexPath.row]
        let sepr = note.components(separatedBy: "space")
        cell.titleLbl.text = sepr[0]
        cell.detailLbl.text = sepr[1]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            notes.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.set(notes, forKey: "Notes")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditNoteViewController") as! EditNoteViewController
            vc.note = notes
            vc.index = indexPath.row
            vc.editNotesDelegate = self
        self.present(vc, animated: true)
    }
}
