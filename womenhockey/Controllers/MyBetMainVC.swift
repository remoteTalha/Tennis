//
//  MyBetMainVC.swift
//  womenhockey
//
//  Created by Anish on 9/13/22.
//

import UIKit
import XLPagerTabStrip

class MyBetMainVC: ButtonBarPagerTabStripViewController {

    let greenColor = UIColor(hex: "AFED45")
    override func viewDidLoad() {
        
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = greenColor
       // settings.style.buttonBarItemFont = UIFont(name: "FiraSans-Light", size: 14)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .darkGray
            newCell?.label.textColor = .black
        }
        super.viewDidLoad()
        buttonBarView.selectedBar.frame.origin.y = buttonBarView.frame.size.height - settings.style.selectedBarHeight
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyBetsViewController") as! MyBetsViewController
        
        
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BetStatsViewController") as! BetStatsViewController
       
      
        
        
        return [child_1,child_2]
        
    }

}
