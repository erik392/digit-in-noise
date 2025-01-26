//
//  UIViewControllerExtension.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/26.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let buttonAction = UIAlertAction(title: button, style: UIAlertAction.Style.default) { _ in
            completion?()
        }
        alert.addAction(buttonAction)
        self.present(alert, animated: true, completion: nil)
    }
}
