//
//  ViewController.swift
//  Example
//
//  Created by Miguel Revetria on 12/7/15.
//  Copyright © 2015 Xmartlabs. All rights reserved.
//

import UIKit
import XLSwiftKit

class MainViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func showImagePickerButtonDidTouch(sender: AnyObject) {
        showImagePicker(.SavedPhotosAlbum)
    }
    
    var overlayView : UIView? = nil
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = .CurrentContext
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        
        if sourceType == .Camera {
            imagePickerController.showsCameraControls = false
            imagePickerController.cameraOverlayView = overlayView
        }
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true) {
            image?.saveToCameraRoll() { [weak self] succeded in
                let alert : UIAlertController
                if succeded {
                    alert = UIAlertController(title: "Image saved to camera roll", message: "", preferredStyle: .Alert)
                } else {
                    alert = UIAlertController(title: "Image couldn't be saved to camera roll", message: "", preferredStyle: .Alert)
                }
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                    })
                self?.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { [weak self] in
            let alert = UIAlertController(title: "Cancelled action", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in
                
                })
            self?.presentViewController(alert, animated: true, completion: nil)
        }
    }


}

class TransparentNavigationBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setTransparent(true)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setTransparent(false)
    }
}

class AnimationsViewController: UIViewController {
    
    
    @IBAction func shakeButtonDidTouch(sender: AnyObject) {
        sender.shake(0.3)
    }
    
    @IBAction func spinButtonDidTouch(sender: AnyObject) {
        sender.spin(0.5, rotations: 2.0, repeatCount: 2.0)
    }
    
}
