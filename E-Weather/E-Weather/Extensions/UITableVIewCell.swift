//
//  UITableVIew.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import UIKit

extension UITableViewCell {
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

