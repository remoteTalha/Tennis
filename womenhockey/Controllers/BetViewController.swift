//
//  BetViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/09/2022.
//

import UIKit
import XLPagerTabStrip
class BetStatsViewController: UIViewController ,IndicatorInfoProvider{
    
    @IBOutlet weak var StatUIView: UIView!
    @IBOutlet weak var BetUIView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatUIView.isHidden = false
        // Do any additional setup after loading the view.
    }
    //MARK: - Actions
    @IBAction func betTapped(_ sender: UIButton) {
        self.BetUIView.isHidden = false
        self.StatUIView.isHidden = true
    }
    @IBAction func statTapped(_ sender: UIButton) {
        self.BetUIView.isHidden = true
        self.StatUIView.isHidden = false
        print("Talhaa")
    }
    //MARK:- SWIPE CONTROLLER METHOD
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Stat")
    }
}
extension BetStatsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 345
    }
}
