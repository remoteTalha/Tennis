//
//  NewsViewController.swift
//  womenhockey
//
//  Created by MAC  on 08/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON


class NewsViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var tempNews = [News]()
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getResults()
    }
}
extension NewsViewController: UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.title.text = news[indexPath.row].title
        let publishedAt = news[indexPath.row].publishedAt.components(separatedBy: "T")
        cell.publishedAt.text = publishedAt[0]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDatailViewController") as! NewsDatailViewController
        vc.webUrl = news[indexPath.row].url
        self.present(vc, animated: true)
    }
}

extension NewsViewController {
    func getResults(){
        self.showHUD()
        let url = "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=8e094b957b0a44f2b5d9c68353f919aa"
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                let data : JSON = JSON(response.result.value!)
               // print(data)
                self.parseNews(json: data["articles"])
            }else {
                self.hideHUD()
            }
        }
    }
    
    func parseNews(json:JSON){
        for item in json {
            let title = item.1["title"].string ?? ""
            let url = item.1["url"].string ?? ""
            let publishedAt = item.1["publishedAt"].string ?? ""
            let data = News(title: title, url: url, publishedAt: publishedAt)
            self.tempNews.append(data)
        }
        self.news = tempNews
        self.hideHUD()
        self.tableView.reloadData()
    }
}
