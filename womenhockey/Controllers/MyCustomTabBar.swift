//
//  MyCustomTabBar.swift
//  Soccer
//
//  Created by Anish on 9/28/22.
//

import UIKit

class MyCustomTabBar: UIViewController {

    var selectedIndex: Int = 3
    var previousIndex: Int = 0
    var viewControllers = [UIViewController]()
    var selectedBtnColor = UIColor(hex:"FC450F")
    @IBOutlet var buttons:[UIButton]!
    @IBOutlet var tabView:UIView!
    var footerHeight: CGFloat = 90
    
    static let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImportantMatchViewController")
    static let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController")
    static let thirdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchTeamStatsViewController")
    static let fourthVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers.append(MyCustomTabBar.firstVC)
        viewControllers.append(MyCustomTabBar.secondVC)
        viewControllers.append(MyCustomTabBar.thirdVC)
        viewControllers.append(MyCustomTabBar.fourthVC)
        
        buttons[selectedIndex].isSelected = true
        tabChanged(sender: buttons[selectedIndex])
        
    }
    
    //MARK:- ACTIONS
    @IBAction func tabChanged(sender:UIButton) {
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        
        if selectedIndex == 0 {
            self.buttons[0].setTitleColor(selectedBtnColor, for: .normal)
            self.buttons[1].setTitleColor(UIColor.white, for: .normal)
            self.buttons[2].setTitleColor(UIColor.white, for: .normal)
            self.buttons[3].setTitleColor(UIColor.white, for: .normal)
        }else if selectedIndex == 1{
            self.buttons[0].setTitleColor(UIColor.white, for: .normal)
            self.buttons[1].setTitleColor(selectedBtnColor, for: .normal)
            self.buttons[2].setTitleColor(UIColor.white, for: .normal)
            self.buttons[3].setTitleColor(UIColor.white, for: .normal)
        }else if selectedIndex == 2 {
            self.buttons[0].setTitleColor(UIColor.white, for: .normal)
            self.buttons[1].setTitleColor(UIColor.white, for: .normal)
            self.buttons[2].setTitleColor(selectedBtnColor, for: .normal)
            self.buttons[3].setTitleColor(UIColor.white, for: .normal)
        }else if selectedIndex == 3 {
            self.buttons[0].setTitleColor(UIColor.white, for: .normal)
            self.buttons[1].setTitleColor(UIColor.white, for: .normal)
            self.buttons[2].setTitleColor(UIColor.white, for: .normal)
            self.buttons[3].setTitleColor(selectedBtnColor, for: .normal)
        }
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabView)
        
        
    }
    
    func hideHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.tabView.frame = CGRect(x: self.tabView.frame.origin.x, y: (self.view.frame.height + self.view.safeAreaInsets.bottom + 16), width: self.tabView.frame.width, height: self.footerHeight)
        })
    }
    
    func showHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.tabView.frame = CGRect(x: self.tabView.frame.origin.x, y: self.view.frame.height - (self.footerHeight + self.view.safeAreaInsets.bottom + 16), width: self.tabView.frame.width, height: self.footerHeight)
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
