//
//  FaceRegisterVC.swift
//  hack2
//
//  Created by snow on 2017. 3. 5..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit
import Alamofire

class FaceRegisterVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var faceImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func cameraButtonDidClick(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - View Event Methods
    
    
    @IBAction func nextButtonDidClick(_ sender: Any) {
        
        //                let RegisterVC = UIStoryboard(name: "RegisterVC", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC")
        //                self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    
}

// MARK: - ImagePickerDelegate

extension FaceRegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            faceImageView.contentMode = .scaleAspectFit
            faceImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
