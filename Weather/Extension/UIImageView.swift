//
//  UIImageView.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit

extension UIImageView {
    
    ///  Realiza una animacion de tipo fade, mientras se intercambia la imagen actual
    /// - Parameter image: Nueva imagen 
    func animateUpdateImage(_ image: UIImage) {
        UIView.transition(with: self,
                          duration: 2.0,
                          options: .transitionCrossDissolve,
                          animations: {
            self.image = image
        }, completion: nil)
    }
    
}
