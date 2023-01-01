//
//  UIImageView+Extension.swift
//  Ray7
//
//  Created by Mohamed Samy on 12/13/19.
//  Copyright © 2019 Mohamed Samy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from:String){
        if let url = URL(string:from.encodeUrl()) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url,placeholder: UIImage.init(named: "Image-Avatar"))
        }else{
            self.image = nil
        }
    }
}


extension UIViewController {
    public func showAlertView(title:String,subTitle:String,primaryButtonAction:((UIAlertAction) -> ())? = nil,primaryButtonTitle:String? = nil){
        
        let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.red
        let okAction = UIAlertAction(title: (primaryButtonTitle != nil) ? primaryButtonTitle : "Ok", style: .default, handler: primaryButtonAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    public func showAlertViewWithTwoButtons(title:String,subTitle:String,primaryButtonAction:((UIAlertAction) -> ())? = nil,secondButtonAction:((UIAlertAction) -> ())? = nil,primaryButtonTitle:String? = nil, secondButtonTitle:String? = nil){
        let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.red
        let okAction = UIAlertAction(title: (primaryButtonTitle != nil) ? primaryButtonTitle : "Ok", style: .default, handler: primaryButtonAction)
        let secondButton = UIAlertAction(title: (secondButtonTitle != nil) ? secondButtonTitle : "Cancel", style: .default, handler: secondButtonAction)
        alertController.addAction(okAction)
        alertController.addAction(secondButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
