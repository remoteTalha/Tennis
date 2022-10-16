//
//  TennisCalanderVC.swift
//  TennisInteractive
//
//  Created by Anish on 10/12/22.
//

import UIKit
import KRProgressHUD
import Alamofire
import SwiftyJSON
import FSCalendar



class TennisCalanderVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendarTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    
    var match = [MatchData]()
    var finalMatch = [MatchData]()
    var selectionDate = ""
    var firstDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        // Do any additional setup after loading the view.
        if firstDate != nil
        {
            self.getMatches(date: firstDate!)
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        calendar.setCurrentPage(date, animated: true)
        calendar.select(date)
        self.firstDate = date
        
    }
   

}
extension TennisCalanderVC {
    func getMatches(date: Date) {
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
                
                let matchData = MatchData(matchId: matchId, homeTeamId: homeTeamId, homeTeamName: homeTeamName, awayTeamId: awayTeamId, awayTeamName: awayTeamName, matchStartTime: matchStartTime, matchDay: self.firstDate!)
                self.match.append(matchData)
            }
        }
        self.finalMatch = self.match
        self.calendarTableView.reloadData()
        KRProgressHUD.dismiss()
    }
}
struct MatchData {
    let matchId : String
    let homeTeamId : String
    let homeTeamName : String

    let awayTeamId : String
    let awayTeamName : String

    let matchStartTime:String
    let matchDay : Date
}

