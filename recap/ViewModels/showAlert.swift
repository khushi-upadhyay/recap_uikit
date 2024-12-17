//
//  showAlert.swift
//  recap
//
//  Created by Diptayan Jash on 15/12/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String = "Error", message: String, actionTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ok", style: .default) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
}
