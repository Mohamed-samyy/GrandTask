//
//  UITextField+Extenstion.swift
//  shoqir
//
//  Created by Mohamed Samy on 3/19/20.
//  Copyright © 2020 Mohamed Samy. All rights reserved.
//

import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 8, y: 8, width: 16, height: 16))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 8, y: 8, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        if LanguageManager.currentLanguageCode() == "ar"{
            leftView = iconContainerView
             leftViewMode = .always
            
        }else if LanguageManager.currentLanguageCode() == "en"{
            rightView = iconContainerView
            rightViewMode = .always
        }
    }
}
