//
//  MatchHistoryCell.swift
//  Tennis interactive
//
//  Created by Anish on 10/16/22.
//

import UIKit

class MatchHistoryCell: UITableViewCell {

    @IBOutlet weak var homeTeamName : UILabel!
    @IBOutlet weak var homeTeamGoals : UILabel!
    @IBOutlet weak var awayTeamName : UILabel!
    @IBOutlet weak var awayTeamGoals : UILabel!
    @IBOutlet weak var startTime : UILabel!
    @IBOutlet weak var startDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setHistoryValues(match:MatchHistory) {
        self.awayTeamName.text = match.awayTeamName
        self.awayTeamGoals.text = "\(match.awayTeamGoals)"
        self.homeTeamName.text = match.homeTeamName
        self.homeTeamGoals.text = "\(match.homeTeamGoals)"
    }
}
