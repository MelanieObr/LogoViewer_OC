//
//  ViewController.swift
//  LogoViewer
//
//  Created by Ambroise COLLON on 24/04/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func didTapSearchButton() {
        searchLogo(domain: textField.text)
    }
        
        
        private func searchLogo(domain: String?) {
            guard domain != "" else {
                return presentAlert(with: "Domain is required")
            }
            
            toggleActivityIndicator(shown: true)
            
            LogoService.shared.getLogo(domain: domain!) { (success, logo) in
                self.toggleActivityIndicator(shown: false)
                if success, let logo = logo {
                    self.updateLogo(logo: logo)
                } else {
                    self.presentAlert(with: "The logo download failed.")
                }
            }
        }


    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

    private func getDomain() -> String {
        let text = textField.text
        if text == "" {
            return "openclassrooms.com"
        }
        return text!
    }
    
    private func updateLogo(logo: Logo) {
        imageView.image = UIImage(data: logo.imageData)
    }
    
    private func presentAlert(with message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    
private func toggleActivityIndicator(shown: Bool) {
    searchButton.isHidden = shown
    activityIndicator.isHidden = !shown
}
}
    extension ViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

