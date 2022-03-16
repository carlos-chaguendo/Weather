//
//  LocationPreviewTableViewController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit

class LocationPreviewTableViewController: UITableViewController {
        
    private let woeid: Int
    
    ///  PInicializa la previzualizacion del clima segun una ubicacion
    /// - Parameter woeid: Where On Earth ID
    init(woeid: Int) {
        self.woeid = woeid
        super.init(nibName: String(describing: LocationPreviewTableViewController.self), bundle: Bundle.main)
    }
    
    @available(*, unavailable, message: "Cat not use inside storyboard")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
