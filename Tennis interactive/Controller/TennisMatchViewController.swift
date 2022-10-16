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
        formatter.dateFormat = "dd/MM/yyyy"
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
        Alamofire.request("https://tennisapi1.p.rapidapi.com/api/tennis/events/\(date)", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                //print(data)
                self.parseMatches(json: data["events"])
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }
    func parseMatches(json:JSON) {
        for item in json {
            if item.1["status"]["type"].string ?? "" == "notstarted" {
                let matchId : Int = item.1["id"].int ?? 0
                let homeTeamId : Int = item.1["homeTeam"]["id"].int ?? 0
                let homeTeamName : String = item.1["homeTeam"]["name"].string ?? ""
                // let homeTeamImage : String = item.1["homeTeam"][""].string ?? ""
                let awayTeamId : Int = item.1["awayTeam"]["id"].int ?? 0
                let awayTeamName : String = item.1["awayTeam"]["name"].string ?? ""
                //    let awayTeamImage : String = item.1[].string ?? ""
                let matchStartTime:Int = item.1["startTimestamp"].int ?? 0
                
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
    let matchId : Int
    let homeTeamId : Int
    let homeTeamName : String
 //   let homeTeamImage : String
    let awayTeamId : Int
    let awayTeamName : String
 //   let awayTeamImage : String
    let matchStartTime:Int
    let matchDay : String
}
