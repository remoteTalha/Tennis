//
//  HistoryTennisViewController.swift
//  womenhockey
//
//  Created by MAC  on 07/10/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class HistoryTennisViewController: UIViewController {
    
    @IBOutlet weak var historymatchTblView: UITableView!
    
    var teamId = ""
    var match = [MatchHistory]()
    var finalMatch = [MatchHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.getMatches(id: teamId)
    }
    
    @IBAction func backButton(sender:UIButton)  {
        self.dismiss(animated: true)
    }
    
    
    
}
extension HistoryTennisViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalMatch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! MatchHistoryCell
        cell.setHistoryValues(match: finalMatch[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = finalMatch[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "MatchStatsVC") as! MatchStatsVC
        vc.awayPlayerId = data.awayPlayerId
        vc.homePlayerId = data.homePlayerId
        vc.matchId = data.matchId
        self.present(vc, animated: true)
    }
    
}

extension HistoryTennisViewController {
    func getMatches(id:String) {
        KRProgressHUD.show()
        Alamofire.request("https://api.sportradar.com/tennis/trial/v3/en/competitors/\(id)/summaries.json?api_key=v5mprf2qxypr3vveem32tq6d", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                print(data)
                self.parseMatches(json: data["summaries"])
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }
    //sportsRadar k3wvgs7zpqnfzrwgp58pp2dt
    // hitting the firstpitch, winning the first serve,second serve,ace,double mistakes
    
    func parseMatches(json:JSON) {
        for item in json {
         //   let stadiumName = item.1["sport_event"]["venue"]["name"].string ?? ""
           // let countryName = item.1["sport_event"]["venue"]["country_name"].string ?? ""
            let matchId = item.1["sport_event"]["id"].string ?? ""
            let matchStartTime = item.1["sport_event"]["start_time"].string ?? ""
            let homeTeamName : String = item.1["sport_event"]["competitors"][0]["name"].string ?? ""
            let homeTeamPlayerId : String = item.1["sport_event"]["competitors"][0]["id"].string ?? ""
            let homeTeamGoal : Int = item.1["sport_event_status"]["home_score"].int ?? 0
            let awayTeamGoal : Int = item.1["sport_event_status"]["away_score"].int ?? 0
            let awayTeamName : String = item.1["sport_event"]["competitors"][1]["name"].string ?? ""
            let awayTeamPlayerId : String = item.1["sport_event"]["competitors"][1]["id"].string ?? ""
            
            
            
            let matchData = MatchHistory(homePlayerId:homeTeamPlayerId,homeTeamName: homeTeamName, homeTeamGoals: homeTeamGoal, awayTeamName: awayTeamName, awayTeamGoals: awayTeamGoal,awayPlayerId: awayTeamPlayerId ,matchStartTime: matchStartTime,matchId: matchId)
            self.match.append(matchData)
            
        }
        self.finalMatch = self.match
        self.historymatchTblView.reloadData()
        KRProgressHUD.dismiss()
    }
}

struct MatchHistory {
    
    let homePlayerId : String
    let homeTeamName : String
    let homeTeamGoals : Int
    let awayTeamName : String
    let awayTeamGoals : Int
    let awayPlayerId  :String
    let matchStartTime:String
    let matchId :String
    
}
