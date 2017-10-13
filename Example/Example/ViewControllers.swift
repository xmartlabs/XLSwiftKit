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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func showImagePickerButtonDidTouch(_ sender: AnyObject) {
        showImagePicker(.savedPhotosAlbum)
    }

    var overlayView: UIView?

    func showImagePicker(_ sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = .currentContext
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self

        if sourceType == .camera {
            imagePickerController.showsCameraControls = false
            imagePickerController.cameraOverlayView = overlayView
        }

        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true) {
            image?.saveToCameraRoll { [weak self] succeded in
                let alert: UIAlertController
                if succeded {
                    alert = UIAlertController(title: "Image saved to camera roll", message: "", preferredStyle: .alert)
                } else {
                    alert = UIAlertController(title: "Image couldn't be saved to camera roll", message: "", preferredStyle: .alert)
                }
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    })
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) { [weak self] in
            let alert = UIAlertController(title: "Cancelled action", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self?.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func changeRootViewController(_ sender: AnyObject) {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewRootViewController")
        UIApplication.changeRootViewController(navigationController)
    }

}

class TransparentNavigationBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setTransparent(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setTransparent(false)
    }

}

class AnimationsViewController: UIViewController {

    @IBAction func shakeButtonDidTouch(_ sender: UIButton) {
        sender.shake(0.3)
    }

    @IBAction func spinButtonDidTouch(_ sender: UIButton) {
        sender.spin(0.5, rotations: 2.0, repeatCount: 2.0)
    }

}

class NewRootViewController: UIViewController {

    @IBAction func buttonTapped(_ sender: AnyObject) {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        UIApplication.changeRootViewController(navigationController)
    }

}
