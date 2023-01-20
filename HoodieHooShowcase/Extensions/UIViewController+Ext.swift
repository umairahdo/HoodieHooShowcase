//
//  Alert.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil,
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AppMessages.alertOkButton,
                                          style: .default))
            self.present(alert, animated: true)
        }
    }
}
