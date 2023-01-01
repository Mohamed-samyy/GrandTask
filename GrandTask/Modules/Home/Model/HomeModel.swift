//
//  HomeModel.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit

struct HomeData: Codable {
    var status : String?
    var totalResults : Int?
    var articles : [Articles]?
    var message : String?

}


struct Articles: Codable {
    var source : Source?
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
    var content : String?
}

struct Source: Codable {
    var id : String?
    var name : String?
}
