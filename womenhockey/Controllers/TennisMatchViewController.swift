//
//  TennisMatchViewController.swift
//  womenhockey
//
//  Created by MAC  on 07/10/2022.
//

import UIKit

class TennisMatchViewController: UIViewController {
    
    @IBOutlet weak var matchTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        matchTableView.dataSource = self
    }

}
extension TennisMatchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
