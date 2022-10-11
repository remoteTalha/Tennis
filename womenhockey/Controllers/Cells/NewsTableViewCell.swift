//
//  NewsTableViewCell.swift
//  womenhockey
//
//  Created by Anish on 9/12/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var publishedAt : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
