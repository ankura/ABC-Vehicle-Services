//
//  ApiManager.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Class to get data from server

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let sharedInstance = APIManager()
    
    private init(){
    }
    
    open class MyServerTrustPolicyManager: ServerTrustPolicyManager {
        open override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
            return ServerTrustPolicy.disableEvaluation}
    }
    
    private var myConfgureCurrentSession: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(TIMEOUT_API)
        return configuration
    }()
    
    lazy var sessionManager = SessionManager(configuration: myConfgureCurrentSession, delegate:SessionDelegate(), serverTrustPolicyManager:MyServerTrustPolicyManager(policies: [:]))
    
    
    
    /// Method to get list data from server
    /// - Parameter completionBlock: completion block for handling the response/error
    func getList(completionBlock :@escaping (JSON)->Void) {
        var tempResponse : JSON? = nil
        let net = NetworkReachabilityManager()
        net?.startListening()
        net?.listener =
            { status in
                net?.stopListening()
                if  net?.isReachable ?? false
                {
                    let baseurl = URL(string: API_URL)
                    Common.LogInfo("URL - " + API_URL, .network)
                    self.sessionManager.request(baseurl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:])
                        .responseJSON { response in if response.result.isSuccess{if((response.value) != nil){
                            tempResponse = JSON(response.result.value!)
                            Common.LogInfo("Response - " + Common.getJsonString(describing:tempResponse), .network)
                            completionBlock(tempResponse!)
                        }else{
                            tempResponse = nil
                            Common.LogInfo("Response - Nil", .network)
                            completionBlock(tempResponse ?? "nil")
                            }
                        }else
                        {
                            Common.LogInfo("Response - Timed Out", .network)
                            completionBlock(tempResponse ?? JSON(Common.jsonObject(from:"")))
                            }
                    }
                }
                else{
                    Common.LogInfo("no connection", .network)
                    completionBlock(tempResponse ?? JSON(Common.jsonObject(from:"")))
                }}
    }
    
    
}
