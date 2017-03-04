//
//  MainVC.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gameStartButtonDidClick(_ sender: Any) {
        let gameVC = UIStoryboard(name: "GameVC", bundle: nil).instantiateViewController(withIdentifier: "GameVC")
        self.navigationController?.pushViewController(gameVC, animated: true)
    }

}
