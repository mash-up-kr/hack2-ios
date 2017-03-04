//
//  RegisterVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController {
    
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
    
    
    @IBAction func nextButtonDidClick(_ sender: Any) {
        let DetailRegisterVC = UIStoryboard(name: "DetailRegisterVC", bundle: nil).instantiateViewController(withIdentifier: "DetailRegisterVC")
        self.navigationController?.pushViewController(DetailRegisterVC, animated: true)
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

extension RegisterVC {
    
    func req() {
        
        do {
            try Alamofire.upload(multipartFormData: { multipartFormData in
                if let image = UIImage(named: "close"), let imageData = UIImagePNGRepresentation(image) {
                    //multipartFormData.append(imageData, withName: "files")
                    multipartFormData.append(imageData, withName: "files" ,fileName: "close.png", mimeType: "multipart/form-data")
                   
                    
                }
            }, to: "http://192.168.0.25:8080/api/game_images", encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    //print("JSON: \(upload.request?.)")
                    upload.responseJSON { response in
                        print(response.request ?? 0)
                        print(response.response ?? 0)
                        print(response.data ?? 0)
                        print(response.result)
                        
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                        }
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
            
        } catch {
            
        }
        
        //let aa = try Alamofire.request("http://192.168.0.25:8080/api/game_images", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        
    }
    
}
