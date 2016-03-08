//
//  NodeCluster.swift
//  Docker
//
//  Created by baga on 3/8/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

enum NodeClusterState: String {
    case Init
    case Deploying
    case Deployed
    case PartlyDeployed = "Partly deployed"
    case Scaling
    case Terminating
    case Terminated
    case EmptyCluster = "Empty cluster"
}

struct NodeCluster {
    let current_num_nodes: Int
    let disk: Double
    let nickname: String
    let name: String
    let target_num_nodes: Int
    let uuid: String
    let region: String
    let state: NodeClusterState
    
    let deployed_datetime: NSDate?
    
    init(current_num_nodes: Int, disk: Double, nickname: String, name: String, target_num_nodes: Int, uuid: String, region: String,  state: NodeClusterState, deployed_datetime: NSDate? = nil){
        self.current_num_nodes = current_num_nodes
        self.disk              = disk
        self.nickname          = nickname
        self.name              = name
        self.target_num_nodes  = target_num_nodes
        self.uuid              = uuid
        self.region            = region
        self.state             = state
        self.deployed_datetime = deployed_datetime
    }
}

struct NodeClusterParser : JSONParserType {
    static func parseJSON(json: JSONDictionary) -> NodeCluster? {
        guard let     current_num_nodes = json["current_num_nodes"] as? Int,
            disk                        = json["disk"] as? Double,
            nickname                    = json["nickname"] as? String,
            name                        = json["name"] as? String,
            target_num_nodes            = json["target_num_nodes"] as? Int,
            uuid                        = json["uuid"] as? String,
            region                      = json["region"] as? String,
            state                       = json["state"] as? String,
            cluster_state               = NodeClusterState(rawValue: state)
        else {
                return nil
        }
        let deployed_date_string = json["deployed_datetime"] as? String
        let deployed_datetime : NSDate? = deployed_date_string != nil ? CloudDateParser().dateFromString(deployed_date_string!) : nil
        let node_cluster = NodeCluster(current_num_nodes: current_num_nodes, disk: disk, nickname: nickname, name: name, target_num_nodes: target_num_nodes, uuid: uuid, region: region,state: cluster_state, deployed_datetime: deployed_datetime)
        return node_cluster
    }
}