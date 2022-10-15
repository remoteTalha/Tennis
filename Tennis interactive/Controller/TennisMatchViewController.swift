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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchTableView.dataSource = self
        getMatches()
    }

}
extension TennisMatchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension TennisMatchViewController {
    func getMatches() {
        Alamofire.request("https://tennisapi1.p.rapidapi.com/api/tennis/events/7/7/2022", method: .get, encoding: JSONEncoding.default, headers: HEADER).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
                print(data)
            }else {
                
            }
        }
    }
}
