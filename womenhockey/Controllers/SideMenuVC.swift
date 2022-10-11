//
//  HistoryViewController.swift
//  womenhockey
//
//  Created by Anish on 9/11/22.
//

import UIKit

class SideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func home(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(vc!, animated: true)
    }
    @IBAction func bets(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BetsVC") as! BetsVC
        self.present(vc, animated: true)
    }
    
    @IBAction func myBets(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyBetMainVC") as! MyBetMainVC
        self.present(vc, animated: true)
    }
    
    @IBAction func news(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func notes(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func calander(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func interavtive(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(vc, animated: true)
    }
    
}
