//
//  TennisNotesVC.swift
//  TennisInteractive
//
//  Created by Anish on 10/12/22.
//

import UIKit

class TennisNotesVC: UIViewController {

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
    
    @IBAction func addNotes(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewNoteVC") as! AddNewNoteVC
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
    
    
}
