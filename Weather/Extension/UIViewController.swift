//
//  UIViewController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import Foundation
import UIKit

extension UIViewController {

    ///  maneja los errores globales, puede postrar erroes a el usuario o ignoral algunos
    /// - Parameter error: 
    func showError(_ error: Error) {
        print(error)
        let error = error as NSError
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept", style: .cancel))
        self.present(alert, animated: true)
    }

}
