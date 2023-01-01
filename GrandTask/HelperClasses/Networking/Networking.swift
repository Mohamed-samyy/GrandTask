

import UIKit
import Alamofire


typealias Handler = (_ response:Any? ,_ error:String?) -> Void

class Networking: NSObject {

    class func RequestAPI<T : Codable>(baseUrl : String, path : String ,method:HTTPMethod, params: [String : Any]? = nil ,headers : HTTPHeaders? = nil,encoding : ParameterEncoding = JSONEncoding.default,model : T? ,completionHandler: @escaping Handler)   {


        var CustomHeaders = HTTPHeaders()

            CustomHeaders = [
                           "Accept":"application/json",
                       ]


        let fullPAth = baseUrl + path

        print("FULL_PATH : ",fullPAth)
        print("FULL_HEADERS : ",CustomHeaders)
        print("FULL_PARAMS : ",params ?? [:])
        
        
        AF.request(fullPAth, method: method, parameters: params, encoding: encoding, headers: CustomHeaders).responseJSON { (response) in

            if response.error != nil && response.response?.statusCode == nil {
                completionHandler(nil,response.error?.localizedDescription)

                Alert.show(message: response.error?.localizedDescription ?? "لا يوجد اتصال بالانترنت")

                return
            }

            print(response.value ?? "")

            switch response.result {
            case .success(let data):
                print(data)
                mapResopnse(response: data as! [String : Any], model: model, completionHandler: completionHandler)
            case .failure(let error):
                print(error)
                completionHandler(nil, "Not Authorized")
            default:
                return
            }
        }
    }

    static func mapResopnse<TModel: Codable>(response : Any ,model : TModel,completionHandler: @escaping Handler ) {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: response
                , options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let allResponse = try jsonDecoder.decode(TModel.self, from: data!)
            completionHandler(allResponse, nil)
                       
        }
        catch {
              completionHandler(nil,error.localizedDescription)
        }

    }
}

