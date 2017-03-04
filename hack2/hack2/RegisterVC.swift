//
//  RegisterVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillChangeFrame(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
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
    
    func keyboardWillHide(notification: NSNotification) {
        contentViewBottomConstraint.constant = 88
        
        let animations = {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: animations, completion: nil)
    }

}
