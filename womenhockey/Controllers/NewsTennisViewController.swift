//
//  NewsTennisViewController.swift
//  womenhockey
//
//  Created by MAC  on 06/10/2022.
//

import UIKit

class NewsTennisViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = CompositionalLayoutE()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = createLayout()
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
        return 100

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
