//
//  StaticsViewController.swift
//  womenhockey
//
//  Created by MAC  on 09/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class StaticsViewController: UIViewController {

    @IBOutlet weak var homeTeamImageOutlet: UIImageView!
    @IBOutlet weak var awayTeamImageOutlet: UIImageView!
    @IBOutlet weak var awayTeamNameOutlet: UILabel!
    @IBOutlet weak var homeTeamNameOutlet: UILabel!
    @IBOutlet weak var homeTeamScoreOutlet: UILabel!
    @IBOutlet weak var awayTeamScoreOutlet: UILabel!
    
    @IBOutlet weak var home_goal: UILabel!
    @IBOutlet weak var home_savePercent: UILabel!
    @IBOutlet weak var home_suspensionsMin: UILabel!
    @IBOutlet weak var home_powerPlay: UILabel!
    @IBOutlet weak var home_saves: UILabel!
    @IBOutlet weak var home_suspensionNum: UILabel!
    @IBOutlet weak var home_puck: UILabel!
    @IBOutlet weak var home_Penalties: UILabel!
    @IBOutlet weak var home_GoalAverage: UILabel!
    
    @IBOutlet weak var away_goal: UILabel!
    @IBOutlet weak var away_savePercent: UILabel!
    @IBOutlet weak var away_suspensionsMin: UILabel!
    @IBOutlet weak var away_powerPlay: UILabel!
    @IBOutlet weak var away_saves: UILabel!
    @IBOutlet weak var away_suspensionNum: UILabel!
    @IBOutlet weak var away_puck: UILabel!
    @IBOutlet weak var away_Penalties: UILabel!
    @IBOutlet weak var away_GoalAverage: UILabel!
    
    var matchId = ""
    var homeTeamName = ""
    var homeTeamImage = ""
    var homeTeamScore = ""
    var awayTeamName = ""
    var awayTeamImage = ""
    var awayTeamScore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTeamNameOutlet.text = self.homeTeamName
        self.homeTeamScoreOutlet.text = self.homeTeamScore
        self.awayTeamNameOutlet.text = self.awayTeamName
        self.awayTeamScoreOutlet.text = self.awayTeamScore
        self.home_goal.text = self.homeTeamScore
        self.away_goal.text = self.awayTeamScore
        
        if awayTeamName == "USA" {
            self.awayTeamImageOutlet.image = UIImage(named: "usa")
        }else if awayTeamName == "Canada" {
            self.awayTeamImageOutlet.image = UIImage(named: "canada")
        }else if awayTeamName == "Switzerland" {
            self.awayTeamImageOutlet.image = UIImage(named: "switzerland")
        }else if awayTeamName == "Sweden" {
            self.awayTeamImageOutlet.image = UIImage(named: "sweden")
        }else if awayTeamName == "Japan" {
            self.awayTeamImageOutlet.image = UIImage(named: "japan")
        }else if awayTeamName == "Finland" {
            self.awayTeamImageOutlet.image = UIImage(named: "finland")
        }else if awayTeamName == "Russia (ROC)" {
            self.awayTeamImageOutlet.image = UIImage(named: "russia")
        }else if awayTeamName == "Germany" {
            self.awayTeamImageOutlet.image = UIImage(named: "germany")
        }else if awayTeamName == "Czech Republic" {
            self.awayTeamImageOutlet.image = UIImage(named: "czechia")
        }else if awayTeamName == "Denmark" {
            self.awayTeamImageOutlet.image = UIImage(named: "denmark")
        }else if  awayTeamName == "China"  {
            self.awayTeamImageOutlet.image = UIImage(named: "china")
        }
        if self.homeTeamName == "USA" {
            self.homeTeamImageOutlet.image = UIImage(named: "usa")
        }else if self.homeTeamName == "Canada" {
            self.homeTeamImageOutlet.image = UIImage(named: "canada")
        }else if self.homeTeamName == "Switzerland" {
            self.homeTeamImageOutlet.image = UIImage(named: "switzerland")
        }else if self.homeTeamName == "Sweden" {
            self.homeTeamImageOutlet.image = UIImage(named: "sweden")
        }else if self.homeTeamName == "Japan" {
            self.homeTeamImageOutlet.image = UIImage(named: "japan")
        }else if self.homeTeamName == "Finland" {
            self.homeTeamImageOutlet.image = UIImage(named: "finland")
        }else if self.homeTeamName == "Russia (ROC)" {
            self.homeTeamImageOutlet.image = UIImage(named: "russia")
        }else if self.homeTeamName == "Germany" {
            self.homeTeamImageOutlet.image = UIImage(named: "germany")
        }else if self.homeTeamName == "Czech Republic" {
            self.homeTeamImageOutlet.image = UIImage(named: "czechia")
        }else if self.homeTeamName == "Denmark" {
            self.homeTeamImageOutlet.image = UIImage(named: "denmark")
        }else if  self.homeTeamName == "China"  {
            self.homeTeamImageOutlet.image = UIImage(named: "china")
        }
        // Do any additional setup after loading the view.
        self.getResults()
    }

}

extension StaticsViewController {
    func getResults(){
        self.showHUD()
        let url = BASE_URL+"/matches/\(self.matchId)/summary.json?api_key=\(API_KEY)"
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                print(data)
                self.parseHistory(json: data["statistics"])
            }else {
                self.hideHUD()
            }
        }
    }
    
    func parseHistory(json:JSON) {
        
        
        let home_savePercent = json["teams"][0]["statistics"]["save_percentage"].int ?? 0
        let home_suspensionsMin = json["teams"][0]["statistics"]["suspensions_minutes"].int ?? 0
        let home_powerPlay = json["teams"][0]["statistics"]["power_plays"].int ?? 0
        let home_saves = json["teams"][0]["statistics"]["saves"].int ?? 0
        let home_suspensionNum = json["teams"][0]["statistics"]["suspensions_number"].int ?? 0
        let home_puck = json["teams"][0]["statistics"]["puck_possession"].int ?? 0
        let home_Penalties = json["teams"][0]["statistics"]["penalties"].int ?? 0
        let home_GoalAverage = json["teams"][0]["statistics"]["goals_against_average"].int ?? 0
        
        
        let away_savePercent = json["teams"][1]["statistics"]["save_percentage"].int ?? 0
        let away_suspensionsMin = json["teams"][1]["statistics"]["suspensions_minutes"].int ?? 0
        let away_powerPlay = json["teams"][1]["statistics"]["power_plays"].int ?? 0
        let away_saves = json["teams"][1]["statistics"]["saves"].int ?? 0
        let away_suspensionNum = json["teams"][1]["statistics"]["suspensions_number"].int ?? 0
        let away_puck = json["teams"][1]["statistics"]["puck_possession"].int ?? 0
        let away_Penalties = json["teams"][1]["statistics"]["penalties"].int ?? 0
        let away_GoalAverage = json["teams"][1]["statistics"]["goals_against_average"].int ?? 0
        
        self.home_savePercent.text = "\(home_savePercent)"
        self.home_suspensionsMin.text = "\(home_suspensionsMin)"
        self.home_powerPlay.text = "\(home_powerPlay)"
        self.home_saves.text = "\(home_saves)"
        self.home_suspensionNum.text = "\(home_suspensionNum)"
        self.home_puck.text = "\(home_puck)"
        self.home_Penalties.text = "\(home_Penalties)"
        self.home_GoalAverage.text = "\(home_GoalAverage)"
        
        
        self.away_savePercent.text = "\(away_savePercent)"
        self.away_suspensionsMin.text = "\(away_suspensionsMin)"
        self.away_powerPlay.text = "\(away_powerPlay)"
        self.away_saves.text = "\(away_saves)"
        self.away_suspensionNum.text = "\(away_suspensionNum)"
        self.away_puck.text = "\(away_puck)"
        self.away_Penalties.text = "\(away_Penalties)"
        self.away_GoalAverage.text = "\(away_GoalAverage)"
        self.hideHUD()
    }
}
