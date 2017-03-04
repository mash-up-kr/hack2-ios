//
//  GameResultVC.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class GameResultVC: UIViewController {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var informationBlockImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var informationView: UIView!
    
    @IBOutlet weak var mainButton: UIButton!
    
    var timerCount: Int = 5
    var isInformationBlock: Bool = false {
        didSet {
            
            informationBlockImageView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.defaultUISetting()
        
    }
    
    func defaultUISetting() {
        
        self.mainButton.layer.cornerRadius = 10.0
        
        self.mainButton.layer.borderWidth = 1.0
        self.mainButton.layer.borderColor = UIColor.MainColor.LightGreen.cgColor
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.timerCount -= 1
            print(self.timerCount)
            self.mainButton.setTitle("\(self.timerCount)", for: UIControlState.normal)
        }
        
        let delayTime = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            
            self.isInformationBlock = true
            
            timer.invalidate()
            self.mainButton.setTitle("새로운 이상형 찾기", for: UIControlState.normal)
            self.mainButton.layer.borderWidth = 0.0
            self.mainButton.backgroundColor = UIColor.MainColor.LightGreen
            self.mainButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.mainButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
            
        }
        
    }
    
    @IBAction func mainButtonPressed(_ sender:Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
}
