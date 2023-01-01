//
//  HeadLinesCollectionViewCell.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

class HeadLinesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    func setUpView(data: Articles) {
        authorLabel.text = data.author
        titleLabel.text = data.title
        mainImage.downloaded(from: data.urlToImage ?? "")
    }
}
