//
//  TennisMatchViewController.swift
//  womenhockey
//
//  Created by MAC  on 07/10/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class TennisMatchViewController: UIViewController {
    
    @IBOutlet weak var matchTableView: UITableView!
    var match = [Match]()
    var finalMatch = [Match]()
    var currentDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchTableView.dataSource = self
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = formatter.string(from: date)
        self.currentDate = someDateTime
        getMatches(date:someDateTime)
    }

}
extension TennisMatchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finalMatch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeMatchCell
        cell.setValues(match: finalMatch[indexPath.row])
        cell.awayTeamHistoryBtn.tag = indexPath.row
        cell.homeTeamHistoryBtn.tag = indexPath.row
        cell.homeTeamHistoryBtn.addTarget(self, action: #selector(historyBtnTappedHome(sender:)), for: .touchUpInside)
        cell.awayTeamHistoryBtn.addTarget(self, action: #selector(historyBtnTappedAway(sender:)), for: .touchUpInside)
        return cell
    }
    @objc func historyBtnTappedHome(sender:UIButton) {
        let match = finalMatch[sender.tag]
        let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryTennisViewController") as! HistoryTennisViewController
        vc.teamId = match.homeTeamId
        self.present(vc, animated: true)
        
    }
    @objc func historyBtnTappedAway(sender:UIButton) {
        let match = finalMatch[sender.tag]
        let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryTennisViewController") as! HistoryTennisViewController
        vc.teamId = match.awayTeamId
        self.present(vc, animated: true)
        
    }
}

extension TennisMatchViewController {
    func getMatches(date:String) {
        KRProgressHUD.show()
        Alamofire.request("https://api.sportradar.com/tennis/trial/v3/en/schedules/\(date)/summaries.json?api_key=v5mprf2qxypr3vveem32tq6d", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                //print(data)
                self.parseMatches(json: data["summaries"])
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }
    func parseMatches(json:JSON) {
        for item in json {
            if item.1["sport_event_status"]["status"].string ?? "" == "not_started" {
                let matchId  = item.1["sport_event"]["id"].string ?? ""
                
                let homeTeamId = item.1["sport_event"]["competitors"][0]["id"].string ?? ""
                let homeTeamName : String = item.1["sport_event"]["competitors"][0]["name"].string ?? ""
               
                
                let awayTeamId  = item.1["sport_event"]["competitors"][1]["id"].string ?? ""
                let awayTeamName : String = item.1["sport_event"]["competitors"][1]["name"].string ?? ""
                
                let matchStartTime = item.1["sport_event"]["start_time"].string ?? ""
                
                let matchData = Match(matchId: matchId, homeTeamId: homeTeamId, homeTeamName: homeTeamName, awayTeamId: awayTeamId, awayTeamName: awayTeamName, matchStartTime: matchStartTime, matchDay: self.currentDate)
                self.match.append(matchData)
            }
        }
        self.finalMatch = self.match
        self.matchTableView.reloadData()
        KRProgressHUD.dismiss()
    }
}

struct Match {
    let matchId : String
    let homeTeamId : String
    let homeTeamName : String

    let awayTeamId : String
    let awayTeamName : String

    let matchStartTime:String
    let matchDay : String
}
