//
//  HomeViewController.swift
//  womenhockey
//
//  Created by MAC  on 06/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    let teams = ["Canada (CAN)","United States (USA)","Finland (FIN)","Russian Olympic Committee (ROC)","Switzerland (SUI)","Japan (JPN)","Czechia (CZE)","Sweden (SWE)","China (CHN)","Denmark (DEN)"]
    let teamsId =  ["sr:competitor:5721","sr:competitor:5726","sr:competitor:5728","sr:competitor:822864","sr:competitor:5725","sr:competitor:22241","sr:competitor:72454","sr:competitor:5724","sr:competitor:22240","sr:competitor:95003"]
    let teamImage =  ["canada","usa","finland","russia","switzerland","japan","czechia","sweden","china","denmark"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}


extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.teamName.text = teams[indexPath.row]
        cell.teamLogo.image = UIImage(named: teamImage[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamId = teamsId[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        vc.selectedTeamId = teamId
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension HomeViewController {
    func getTeams() {
        showHUD()
        let url = BASE_URL+"/tournaments/sr:tournament:273/results.json?api_key=ywcm39mxhm56syx3nw4yqrkq"
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
             //   print(data)
                self.parseData(json: data["results"])
            }else {
                self.hideHUD()
            }
        }
    }
    
    func parseData(json:JSON) {
        for item in json {
            let event = item.1["sport_event"].array ?? []
            for values in event {
                var country_code = values["country_code"].string ?? ""
                var qualifier = values["qualifier"].string ?? ""
                var country = values["country"].string ?? ""
                var id = values["id"].string ?? ""
                var name = values["name"].string ?? ""
                var abbreviation = values["abbreviation"].string ?? ""
                
            }
        }
    }
}
