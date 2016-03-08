//
//  CloudClient.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation
import Alamofire


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
    
    func getNodes(udid: String? = nil, state: NodeState? = nil, node_cluster: String? = nil, node_type: String? = nil, region: String? = nil, docker_version: String? = nil, completion: ([Node]?) -> Void ){
        _request(CloudRouter.ListNodes(udid: udid, state: state, node_cluster: node_cluster, node_type: node_type, region: region, docker_version: docker_version))
        .responseJSON { response in
            guard let json = response.result.value, objects = json["objects"] as? [JSONDictionary] else{
                print("Can't parse the data")
                completion(nil)
                return
            }
            let nodes : [Node] = objects.flatMap(NodeParser.parseJSON)
            completion(nodes)
        }
    }
    
    func getNodeClusters(uuid: String? = nil, state: NodeClusterState? = nil, name: String? = nil, region: String? = nil, node_type: String? = nil, completion: ([NodeCluster]?) -> Void ){
        _request(CloudRouter.ListNodeClusters(uuid: uuid, state: state, name: name, region: region, node_type: node_type))
        .responseJSON{ response in
            guard let json = response.result.value, objects = json["objects"] as? [JSONDictionary] else{
                print("Can't parse the data")
                completion(nil)
                return
            }
            
            let nodeClusters : [NodeCluster] = objects.flatMap(NodeClusterParser.parseJSON)
            completion(nodeClusters)
        }
    }
}