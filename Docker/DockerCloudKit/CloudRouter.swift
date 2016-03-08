//
//  Router.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation
import Alamofire


enum CloudRouter: URLRequestConvertible{
    static let baseURLString = "https://cloud.docker.com/"
    
    case ListNodes(udid: String?, state: NodeState?, node_cluster: String?, node_type: String?, region: String?, docker_version: String?)
    case ListNodeClusters(uuid: String?, state: NodeClusterState?, name: String?, region: String?, node_type: String?)
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: JSONDictionary?) = {
            switch self {
            case .ListNodes(let udid,let state,let node_cluster,let node_type,let region,let docker_version):
                var params               = JSONDictionary()
                params["udid"]           = udid
                params["state"]          = state?.rawValue
                params["node_cluster"]   = node_cluster
                params["node_type"]      = node_type
                params["region"]         = region
                params["docker_version"] = docker_version
                return ("api/infra/v1/node/", params)
                
            case .ListNodeClusters(let uuid, let state, let name, let region, let node_type):
                var params          = JSONDictionary()
                params["uuid"]      = uuid
                params["state"]     = state?.rawValue
                params["name"]      = name
                params["region"]    = region
                params["node_type"] = node_type
                return ("api/infra/v1/nodecluster/", params)
            }
        }()
        
        let URL = NSURL(string: CloudRouter.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
    
}