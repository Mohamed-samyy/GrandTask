//
//  HomeAPIs.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//

import UIKit
import Alamofire


protocol HomeAPIsProtocol {
    func APi_Success(response : HomeData)
    func APi_Failed(errorMessage:String)
}

class HomeAPIs: NSObject {
    static let sharedInstance = HomeAPIs()
    var homeDelegate : HomeAPIsProtocol?
    var homeData : HomeData?
    func getNewsApis(pageNumber: Int,searchText: String) {
        var paramters : [String:Any]
            paramters = [
                "q": searchText,
                "apiKey":"04aede68af3f4584a8ae04f1bad2eef0"
                ]

        Networking.RequestAPI(baseUrl: Constants.BaseURL, path: API_EndPoinst.homeNewsData+"?page=\(pageNumber)", method: .get,params: paramters,encoding: URLEncoding(destination: .queryString), model: homeData ) { (response, error) in
            if error == nil {
                self.homeDelegate?.APi_Success(response : response as! HomeData)
            }else{
                self.homeDelegate?.APi_Failed(errorMessage:error!)
            }
        }
    }
}
