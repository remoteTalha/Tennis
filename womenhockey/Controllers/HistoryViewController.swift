//
//  ViewController.swift
//  womenhockey
//
//  Created by MAC  on 06/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tempHistory = [History]()
    var history = [History]()
    var selectedTeamId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getResults()
    }
}
extension HistoryViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyValue = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.setValues(history: historyValue)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchStats = history[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "StaticsViewController") as! StaticsViewController
        vc.matchId = matchStats.matchId
        vc.homeTeamName = matchStats.HomeTeamName
        vc.homeTeamScore = "\(matchStats.home_score)"
        vc.awayTeamName = matchStats.AwayTeamName
        vc.awayTeamScore = "\(matchStats.away_score)"
        self.present(vc, animated: true)
    }
}

extension HistoryViewController {
    
    func getResults(){
        self.showHUD()
        let url = BASE_URL+"/teams/\(self.selectedTeamId)/results.json?api_key=\(API_KEY)"
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
               // print(data)
                self.parseHistory(json: data["results"])
            }else {
                self.hideHUD()
            }
        }
    }
    
    func parseHistory(json:JSON) {
        for item in json {
            let awayTeamPoints = item.1["sport_event_status"]["away_score"].int ?? 0
            let homeTeamPoints = item.1["sport_event_status"]["home_score"].int ?? 0
            let scheduled = item.1["sport_event"]["scheduled"].string ?? ""
            let homeTeamName = item.1["sport_event"]["competitors"][0]["name"].string ?? ""
            let awayTeamName = item.1["sport_event"]["competitors"][1]["name"].string ?? ""
            let matchId = item.1["sport_event"]["id"].string ?? ""
            let data = History(away_score: awayTeamPoints, home_score: homeTeamPoints, scheduled: scheduled, HomeTeamName: homeTeamName, AwayTeamName: awayTeamName, matchId: matchId)
            self.tempHistory.append(data)
        }
        self.history = tempHistory
        self.tableView.reloadData()
        self.hideHUD()
    }
    
}

