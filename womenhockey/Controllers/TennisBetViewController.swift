//
//  TennisBetViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/10/2022.
//

import UIKit

class TennisBetViewController: UIViewController {
    
    @IBOutlet weak var betmatchTblView: UITableView!
    @IBOutlet weak var myBetTableView: UITableView!
    @IBOutlet weak var betView: UIView!
    @IBOutlet weak var myBetView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        betmatchTblView.dataSource = self
        myBetTableView.dataSource = self
        myBetView.isHidden = true
    }
    @IBAction func betTapped(_ sender: UIButton) {
        self.betView.isHidden = false
        self.myBetView.isHidden = true
        
    }
    @IBAction func myBetTapped(_ sender: UIButton) {
        self.betView.isHidden = true
        self.myBetView.isHidden = false
        
    }

}
extension TennisBetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

