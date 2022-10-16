//
//  MatchStatsVC.swift
//  Tennis interactive
//
//  Created by Anish on 10/16/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class MatchStatsVC: UIViewController {
    
    
    @IBOutlet weak var homeTeamNameLbl: UILabel!
    @IBOutlet weak var awayTeamNameLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var startTimeLbl: UILabel!
    
    
    
    var homePlayerId = ""
    var awayPlayerId = ""
    var matchId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMatches(homePlayerid: self.homePlayerId, awayPlayerId: self.awayPlayerId)
    }
    
    @IBAction func backButton(sender:UIButton)  {
        self.dismiss(animated: true)
    }
    
    
}


extension MatchStatsVC {
    func getMatches(homePlayerid:String,awayPlayerId:String) {
        KRProgressHUD.show()
        Alamofire.request("https://api.sportradar.com/tennis/trial/v3/en/competitors/\(homePlayerid)/versus/\(awayPlayerId)/summaries.json?api_key=v5mprf2qxypr3vveem32tq6d", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                print(data)
                self.parseMatches(json: data)
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }

    // hitting the firstpitch, winning the first serve,second serve,ace,double mistakes
    
    func parseMatches(json:JSON) {
        
        let totalMathes =  json["last_meetings"].array ?? []
        for match in totalMathes {
            if match["sport_event"]["id"].string == self.matchId {
                
                let stadiumName = match["sport_event"]["venue"]["name"].string ?? ""
                let countryName = match["sport_event"]["venue"]["country_name"].string ?? ""
                let matchStartTime = match["sport_event"]["start_time"].string ?? ""
                
                let homeTeamName  = match["sport_event"]["competitors"][0]["name"].string ?? ""
                let homeTeamGoal = match["sport_event_status"]["home_score"].int ?? 0
                let homeTeamAce = match["statistics"]["totals"]["competitors"][0]["statistics"]["aces"].string ?? ""
                let homeDoubleMistakes = match["statistics"]["totals"]["competitors"][0]["statistics"]["double_faults"].string ?? ""
                let homeFirstServe = match["statistics"]["totals"]["competitors"][0]["statistics"]["first_serve_successful"].string ?? ""
                let homeSecondServe = match["statistics"]["totals"]["competitors"][0]["statistics"]["second_serve_successful"].string ?? ""
                
                let awayFirstServe = match["statistics"]["totals"]["competitors"][1]["statistics"]["first_serve_successful"].string ?? ""
                let awaySeccondServe = match["statistics"]["totals"]["competitors"][1]["statistics"]["second_serve_successful"].string ?? ""
                let awayDoubleMistakes = match["statistics"]["totals"]["competitors"][1]["statistics"]["double_faults"].string ?? ""
                let awayTeamAce = match["statistics"]["totals"]["competitors"][1]["statistics"]["aces"].string ?? ""
                let awayTeamGoal  = match["sport_event_status"]["away_score"].int ?? 0
                let awayTeamName  = match["sport_event"]["competitors"][1]["name"].string ?? ""
              
                KRProgressHUD.dismiss()
            }
        }
        
    }
}
