//
//  NewsTennisViewController.swift
//  womenhockey
//
//  Created by MAC  on 06/10/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class NewsTennisViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = CompositionalLayoutE()
    var news = [News]()
    var finisedNews = [News]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = createLayout()
        self.getNews()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height:.fractionalHeight(1), spacing: 1)
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.5), spacing: 1)
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1), item: fullItem, count: 2)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.6), items: [item, verticalGroup])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
        
    }
}
extension NewsTennisViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finisedNews.count

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        cell.setValues(values: finisedNews[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDatailViewController") as! NewsDatailViewController
        vc.selectedNews = self.finisedNews[indexPath.row]
        self.present(vc, animated: true)
    }
}

extension NewsTennisViewController {
    
    func getNews(){
        KRProgressHUD.show()
        Alamofire.request(NEWS_API,method: .get).responseJSON { response in
            if response.result.isSuccess {
                let data:JSON = JSON(response.result.value!)
                print(data)
                self.parseNews(json: data["data"]["feed"]["layouts"])
            }else {
                KRProgressHUD.dismiss()
            }
        }
    }
    func parseNews(json:JSON){
        for item in json {
            let id = item.1["contents"][0]["consumable_id"].string ?? ""
            let title = item.1["contents"][0]["title"].string ?? ""
            let news = item.1["contents"][0]["consumable"]["permalink"].string ?? ""
            let image = item.1["contents"][0]["consumable"]["image_uri"].string ?? ""
            let excerpt = item.1["contents"][0]["consumable"]["excerpt"].string ?? ""
            let newsData = News(id: id, news: news, image: image, title: title, excerpt: excerpt)
            self.news.append(newsData)
        }
        self.finisedNews = self.news
        self.collectionView.reloadData()
        KRProgressHUD.dismiss()
    }
}

struct News {
    let id : String
    let news : String
    let image : String
    let title : String
    let excerpt : String
}
