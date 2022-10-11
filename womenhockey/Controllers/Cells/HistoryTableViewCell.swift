//
//  HistoryTableViewCell.swift
//  womenhockey
//
//  Created by Anish on 9/11/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTime : UILabel!
    @IBOutlet weak var homePoints : UILabel!
    @IBOutlet weak var awayPoints : UILabel!
    @IBOutlet weak var homeTeam : UILabel!
    @IBOutlet weak var awayTeam : UILabel!
    @IBOutlet weak var awayTeamImage : UIImageView!
    @IBOutlet weak var homeTeamImage : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValues(history:History){
        let seprateDate = history.scheduled.components(separatedBy: "T")
        self.dateTime.text = seprateDate[0]
        self.homeTeam.text = history.HomeTeamName
        self.homePoints.text = "\(history.home_score)"
        self.awayTeam.text = history.AwayTeamName
        self.awayPoints.text = "\(history.away_score)"
        
        
        
        if history.AwayTeamName == "USA" {
            self.awayTeamImage.image = UIImage(named: "usa")
        }else if history.AwayTeamName == "Canada" {
            self.awayTeamImage.image = UIImage(named: "canada")
        }else if history.AwayTeamName == "Switzerland" {
            self.awayTeamImage.image = UIImage(named: "switzerland")
        }else if history.AwayTeamName == "Sweden" {
            self.awayTeamImage.image = UIImage(named: "sweden")
        }else if history.AwayTeamName == "Japan" {
            self.awayTeamImage.image = UIImage(named: "japan")
        }else if history.AwayTeamName == "Finland" {
            self.awayTeamImage.image = UIImage(named: "finland")
        }else if history.AwayTeamName == "Russia (ROC)" {
            self.awayTeamImage.image = UIImage(named: "russia")
        }else if history.AwayTeamName == "Germany" {
            self.awayTeamImage.image = UIImage(named: "germany")
        }else if history.AwayTeamName == "Czech Republic" {
            self.awayTeamImage.image = UIImage(named: "czechia")
        }else if history.AwayTeamName == "Denmark" {
            self.awayTeamImage.image = UIImage(named: "denmark")
        }else if  history.AwayTeamName == "China"  {
            self.awayTeamImage.image = UIImage(named: "china")
        }
        if history.HomeTeamName == "USA" {
            self.homeTeamImage.image = UIImage(named: "usa")
        }else if history.HomeTeamName == "Canada" {
            self.homeTeamImage.image = UIImage(named: "canada")
        }else if history.HomeTeamName == "Switzerland" {
            self.homeTeamImage.image = UIImage(named: "switzerland")
        }else if history.HomeTeamName == "Sweden" {
            self.homeTeamImage.image = UIImage(named: "sweden")
        }else if history.HomeTeamName == "Japan" {
            self.homeTeamImage.image = UIImage(named: "japan")
        }else if history.HomeTeamName == "Finland" {
            self.homeTeamImage.image = UIImage(named: "finland")
        }else if history.HomeTeamName == "Russia (ROC)" {
            self.homeTeamImage.image = UIImage(named: "russia")
        }else if history.HomeTeamName == "Germany" {
            self.homeTeamImage.image = UIImage(named: "germany")
        }else if history.HomeTeamName == "Czech Republic" {
            self.homeTeamImage.image = UIImage(named: "czechia")
        }else if history.HomeTeamName == "Denmark" {
            self.homeTeamImage.image = UIImage(named: "denmark")
        }else if  history.HomeTeamName == "China"  {
            self.homeTeamImage.image = UIImage(named: "china")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
