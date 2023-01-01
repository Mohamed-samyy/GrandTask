//
//  NewsDetailsViewController.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var newData = Articles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        newsImage.downloaded(from: newData.urlToImage ?? "")
        titleLabel.text = newData.title
        dateLabel.text = newData.publishedAt
        authorLabel.text = newData.author
        descriptionTextView.text = newData.description

    }


}
