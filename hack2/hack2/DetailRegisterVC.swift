//
//  DetailRegisterVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 5..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire

class DetailRegisterVC: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: #selector(DetailRegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(RegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        ageTextField.addTarget(self, action: #selector(DetailRegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        addressField.addTarget(self, action: #selector(DetailRegisterVC.editingChanged), for: UIControlEvents.editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailRegisterVC.keyboardWillChangeFrame(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailRegisterVC.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View Event Methods
    
    @IBAction func nextButtonDidClick(_ sender: Any) {
        let FaceRegisterVC = UIStoryboard(name: "FaceRegisterVC", bundle: nil).instantiateViewController(withIdentifier: "FaceRegisterVC")
        self.navigationController?.pushViewController(FaceRegisterVC, animated: true)
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        guard let keyboardHeght = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        contentViewBottomConstraint.constant = -keyboardHeght + 60
        
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        contentViewBottomConstraint.constant = 0
        
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }
    
    func editingChanged() {
        guard let nameTextCount = nameTextField.text?.characters.count, let phoneNumberTextCount = phoneNumberTextField.text?.characters.count, let ageTextCount = ageTextField.text?.characters.count, let addressTextCount = addressField.text?.characters.count else {
            return
        }
        if 0 < nameTextCount && 0 < phoneNumberTextCount && 0 < ageTextCount && 0 < addressTextCount{
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
