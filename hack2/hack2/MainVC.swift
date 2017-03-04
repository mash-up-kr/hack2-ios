//
//  MainVC.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: UIViewController {
    
    @IBOutlet weak var enterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaultUISetting()
    }
    
    func defaultUISetting() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = self.navigationController
        
        self.enterButton.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func gameStartButtonDidClick(_ sender: Any) {
        let gameVC = UIStoryboard(name: "GameVC", bundle: nil).instantiateViewController(withIdentifier: "GameVC") as! GameVC
        
        let urlString = "http://192.168.0.25:8080/api/games"
        if let url = URL(string: urlString) {
            if let userId = UserDefaults.standard.object(forKey: "user_id") as? String {
                Alamofire.request(url, method: .post, parameters: ["user": userId], encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        let resultJSON = JSON(value)
                        let item = resultJSON["item"]
                        
                        gameVC.gameId = item["id"].intValue
                        self.navigationController?.pushViewController(gameVC, animated: true)
                        
                        break;
                    case .failure(let err):
                        print(err)
                        break;
                    }
                })
            }
            
        }
        
        
    }

}
