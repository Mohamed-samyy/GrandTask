//
//  HomeTableViewCell.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCell(data:Articles) {
        dateLabel.text = data.publishedAt
        authorLabel.text = data.author
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        newsImage.downloaded(from: data.urlToImage ?? "")
    }
}
