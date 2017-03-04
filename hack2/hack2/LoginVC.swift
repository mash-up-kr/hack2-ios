//
//  LoginVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.borderWidth = 1
            loginButton.layer.borderColor = UIColor.MainColor.LightGreen.cgColor
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @IBAction func registerButtonDidClick(_ sender: Any) {
        let RegisterVC = UIStoryboard(name: "RegisterVC", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC")
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    @IBAction func loginButtonDidClick(_ sender: Any) {
        let AccountVC = UIStoryboard(name: "AccountVC", bundle: nil).instantiateViewController(withIdentifier: "AccountVC")
        self.navigationController?.pushViewController(AccountVC, animated: true)
    }
    
    
}
