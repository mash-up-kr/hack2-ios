//
//  ImagePicker.swift
//  hack2
//
//  Created by snow on 2017. 3. 5..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

class ImagePicker: NSObject {
    
    fileprivate weak var viewController: UIViewController!
    
    weak var delegate: ImagePickerDelegate?
    
    var cropEnabled = false
    var aspectRatioLocked = false
    var rotateButtonsHidden = false
    var rotateClockwiseButtonHidden = false
    
    var tag: String?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pickImage(_ sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        viewController.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if cropEnabled {
                
            } else {
                delegate?.imageDidPick(image)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
        delegate?.imagePickDidCancel?()
    }
    
}

@objc protocol ImagePickerDelegate: class {
    
    func imageDidPick(_ image: UIImage)
    @objc optional func imagePickDidCancel()
    
}
