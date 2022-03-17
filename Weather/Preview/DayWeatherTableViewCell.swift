//
//  DayWeatherTableViewCell.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
