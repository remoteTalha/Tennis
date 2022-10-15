//
//  NewsCollectionViewCell.swift
//  Tennis interactive
//
//  Created by Anish on 10/15/22.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsImage : UIImageView!
    @IBOutlet weak var newsTitle : UILabel!
    
    
    func setValues(values:News) {
        if let url  = URL(string: values.image) {
            newsImage.sd_setImage(with: url)
        }
        self.newsTitle.text = values.title
    }
}
