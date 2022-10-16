//
//  HomeMatchCell.swift
//  Tennis interactive
//
//  Created by Anish on 10/15/22.
//

import UIKit

class HomeMatchCell: UITableViewCell {

    @IBOutlet weak var homeTeamName : UILabel!
    @IBOutlet weak var homeTeamHistoryBtn : UIButton!
    @IBOutlet weak var awayTeamName : UILabel!
    @IBOutlet weak var awayTeamHistoryBtn : UIButton!
    @IBOutlet weak var startTime : UILabel!
    @IBOutlet weak var startDate : UILabel!

    
    
    func setValues(match:Match) {
        self.homeTeamName.text = match.homeTeamName
        self.awayTeamName.text = match.awayTeamName
    }
}
