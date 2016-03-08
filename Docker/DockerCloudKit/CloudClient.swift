//
//  CloudClient.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation
import Alamofire

//khoigeeky:713068be-df30-4361-8a78-821b9a946bc1
//a2hvaWdlZWt5OjcxMzA2OGJlLWRmMzAtNDM2MS04YTc4LTgyMWI5YTk0NmJjMQ==
class CloudClient{
    private var _userName: String
    private var _apiKey: String
    private var _authorizationHeader: String
    
    init(userName: String, apiKey: String){
        _userName            = userName
        _apiKey              = apiKey
        _authorizationHeader = {
            return "\(userName):\(apiKey)".toBase64()
        }()
    }
    
    private func signRequest(aRequest: NSMutableURLRequest) -> NSMutableURLRequest{
        aRequest.setValue("Basic \(_authorizationHeader)", forHTTPHeaderField: "Authorization")
        return aRequest
    }
    
    private func _request(cloudRequest: CloudRouter) -> Request{
        let signedRequest = signRequest(cloudRequest.URLRequest)
        return Alamofire.request(signedRequest)
    }
    
    func getNodes(udid: String? = nil, state: String? = nil, node_cluster: String? = nil, node_type: String? = nil, region: String? = nil, docker_version: String? = nil, completion: ([Node]?) -> ()){
        _request(CloudRouter.ListNodes(udid: udid, state: state, node_cluster: node_cluster, node_type: node_type, region: region, docker_version: docker_version))
        .responseJSON { (response) -> Void in
            guard let json = response.result.value, objects = json["objects"] as? [JSONDictionary] else{
                print("Can't parse the data")
                completion(nil)
                return
            }
            let nodes : [Node] = objects.flatMap{ NodeParser().parseJSON($0)  }
            completion(nodes)
        }
    }
}