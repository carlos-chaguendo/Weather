//
//  UItableView.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit

extension UITableView {
    
    /// Regstra una celda para reuso, con el mismo nombre de la clase de la celda
    func register<Cell:UITableViewCell>(_ cell: Cell.Type) {
        self.register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func dequeue<Cell:UITableViewCell>(cell: Cell.Type, for index: IndexPath) -> Cell? {
        self.dequeueReusableCell(withIdentifier: String(describing: cell), for: index) as? Cell
    }
}
