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

    var teamId = 0
    var match = [MatchHistory]()
    var finalMatch = [MatchHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.getMatches(id: teamId)
    }
    


}
extension HistoryTennisViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalMatch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! MatchHistoryCell
        cell.setHistoryValues(match: finalMatch[indexPath.row])
        return cell
    }
}

extension HistoryTennisViewController {
    func getMatches(id:Int) {
        KRProgressHUD.show()
        Alamofire.request("https://tennisapi1.p.rapidapi.com/api/tennis/player/\(id)/events/previous/0", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                print(data)
                self.parseMatches(json: data["events"])
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }
    func parseMatches(json:JSON) {
        for item in json {
                let homeTeamName : String = item.1["homeTeam"]["name"].string ?? ""
                let homeTeamGoal : Int = item.1["homeScore"]["current"].int ?? 0
                let awayTeamGoal : Int = item.1["awayScore"]["current"].int ?? 0
                let awayTeamName : String = item.1["awayTeam"]["name"].string ?? ""
                let matchStartTime:Int = item.1["startTimestamp"].int ?? 0
                
                let matchData = MatchHistory(homeTeamName: homeTeamName, homeTeamGoals: homeTeamGoal, awayTeamName: awayTeamName, awayTeamGoals: awayTeamGoal, matchStartTime: matchStartTime)
                self.match.append(matchData)
            
        }
        self.finalMatch = self.match
        self.historymatchTblView.reloadData()
        KRProgressHUD.dismiss()
    }
}

struct MatchHistory {
   
    let homeTeamName : String
    let homeTeamGoals : Int
    let awayTeamName : String
    let awayTeamGoals : Int
    let matchStartTime:Int
    
}
