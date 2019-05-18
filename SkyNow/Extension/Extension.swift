//
//  Extension.swift
//  SkyNow
//
//  Created by Fatimah Galhoum on 5/17/19.
//  Copyright © 2019 Fatimah Galhoum. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}



extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}


