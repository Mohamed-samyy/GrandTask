//
//  HeadLinesAPIs.swift
//  GrandTask
//
//  Created by Mohamed Samy on 29/12/2022.
//


import UIKit
import Alamofire


protocol HeadLinesAPIsProtocol {
    func APi_Success(response : HomeData)
    func APi_Failed(errorMessage:String)
}

class HeadLinesAPIs: NSObject {
    static let sharedInstance = HeadLinesAPIs()
    var headLinesDelegate : HeadLinesAPIsProtocol?
    var headLinesData : HomeData?
    func getHeadLinesApis(pageNumber: Int,searchText: String) {
        var paramters : [String:Any]
            paramters = [
                "q": searchText,
                "apiKey":"04aede68af3f4584a8ae04f1bad2eef0"
                ]

        Networking.RequestAPI(baseUrl: Constants.BaseURL, path: API_EndPoinst.headLinesData+"?page=\(pageNumber)", method: .get,params: paramters,encoding: URLEncoding(destination: .queryString), model: headLinesData ) { (response, error) in
            if error == nil {
                self.headLinesDelegate?.APi_Success(response : response as! HomeData)
            }else{
                self.headLinesDelegate?.APi_Failed(errorMessage:error!)
            }
        }
    }
}
