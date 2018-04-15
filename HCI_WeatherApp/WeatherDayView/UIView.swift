//
//  UIView.swift
//  HCI_WeatherApp
//
//  Created by Alina Godun on 14.04.18.
//  Copyright © 2018 Alina Godun. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
