//
//  GameResultWaitingVC.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 5..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class GameResultWaitingVC: UIViewController {
    
    @IBOutlet weak var resultCheckButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultUISetting()
    }
    
    func defaultUISetting() {
        
        self.resultCheckButton.layer.cornerRadius = 10.0
        
        self.resultCheckButton.backgroundColor = UIColor(red: 227.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0)
        self.resultCheckButton.setTitleColor(UIColor.SubColor.DarkBlack, for: UIControlState.normal)
        self.resultCheckButton.isUserInteractionEnabled = false
        
        let delayTime = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            
            self.resultCheckButton.backgroundColor = UIColor.MainColor.LightGreen
            self.resultCheckButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.resultCheckButton.isUserInteractionEnabled = true
            
        }
        
    }
    
    @IBAction func resultCheckButtonPressed(_ sender:Any) {
        let gameResultVC = UIStoryboard(name: "GameResultVC", bundle: nil).instantiateViewController(withIdentifier: "GameResultVC")
        
        self.navigationController?.pushViewController(gameResultVC, animated: true)
        
    }

}
