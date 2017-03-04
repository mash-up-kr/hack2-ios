//
//  AccountVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 5..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire

class AccountVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(RegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(RegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillChangeFrame(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Event Methods
    
    
    @IBAction func nextButtonDidClick(_ sender: Any) { //POST
        let userId = emailTextField.text!
        let password = passwordTextField.text!
        let url = "http://192.168.0.25:8080/api/users"
        let parameters: [String : Any] = ["userId" : userId, "password": password]
        
        let result = try Alamofire
            .request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil)

        let MainVC = UIStoryboard(name: "MainVC", bundle: nil).instantiateViewController(withIdentifier: "MainVC")
        self.navigationController?.pushViewController(MainVC, animated: true)
        //navigationController?.present(MainVC, animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        guard let keyboardHeght = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        contentViewBottomConstraint.constant = keyboardHeght + 40
        
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
    
    func keyboardWillHide() {
        contentViewBottomConstraint.constant = 88
        
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
    
    func editingChanged() {
        guard let emailTextCount = emailTextField.text?.characters.count, let passwordTextCount = passwordTextField.text?.characters.count else {
            return
        }
        if 0 < emailTextCount && 0 < passwordTextCount {
            nextButton.backgroundColor = UIColor.MainColor.LightGreen
            nextButton.titleLabel?.textColor = .white
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = UIColor.MainColor.LightGray
            nextButton.titleLabel?.textColor = UIColor.SubColor.DarkBlack
            nextButton.isEnabled = false
        }
    }
    
}

