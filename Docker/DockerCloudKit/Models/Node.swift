//
//  Node.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

enum NodeState : String{
    case Deploying
    case Deployed
    case Unreachable
    case Upgrading
    case Terminating
    case Terminated
}

struct Node{
    
    let cpu: Int
    let current_num_containers: Int
    let disk: Double
    let external_fqdn: String
    let last_seen: NSDate
    let memory: Double
    let nickname: String
    let node_type: String
    let public_ip: String?
    let region: String
    let state: NodeState
    let uuid: String
    let node_cluster: String?
    let deployed_datetime: NSDate?


    init(cpu: Int, current_num_containers: Int, disk: Double, external_fqdn: String, last_seen: NSDate, memory: Double, nickname: String,node_type: String,region: String, state: NodeState, uuid: String, node_cluster: String? = nil, public_ip: String?, deployed_datetime: NSDate? = nil){
        self.cpu                    = cpu
        self.current_num_containers = current_num_containers
        self.disk                   = disk
        self.external_fqdn          = external_fqdn
        self.last_seen              = last_seen
        self.memory                 = memory
        self.nickname               = nickname
        self.node_type              = node_type
        self.public_ip              = public_ip
        self.region                 = region
        self.state                  = state
        self.uuid                   = uuid
        self.node_cluster           = node_cluster
        self.deployed_datetime      = deployed_datetime
    }
    
}


struct NodeParser : JSONParserType {
    static func parseJSON(json: JSONDictionary) -> Node? {
        guard let   cpu                    = json["cpu"] as? Int,
                    current_num_containers = json["current_num_containers"] as? Int,
                    disk                   = json["disk"] as? Double,
                    external_fqdn          = json["external_fqdn"] as? String,
                    last_seen              = json["last_seen"] as? String,
                    last_seen_date         = CloudDateParser().dateFromString(last_seen),
                    memory                 = json["memory"] as? Double,
                    nickname               = json["nickname"] as? String,
                    node_type              = json["node_type"] as? String,
                    region                 = json["region"] as? String,
                    state                  = json["state"] as? String,
                    node_state             = NodeState(rawValue: state),
                    uuid                   = json["uuid"] as? String else{
            return nil
        }
        
        let public_ip    = json["public_ip"] as? String
        let node_cluster = json["node_cluster"] as? String
        
        
        let deployed_date_string = json["deployed_datetime"] as? String
        let deployed_datetime : NSDate? = deployed_date_string != nil ? CloudDateParser().dateFromString(deployed_date_string!) : nil
        let node = Node(cpu: cpu, current_num_containers: current_num_containers, disk: disk, external_fqdn: external_fqdn, last_seen: last_seen_date, memory: memory, nickname: nickname,node_type: node_type, region: region, state: node_state, uuid: uuid, node_cluster: node_cluster, public_ip: public_ip,deployed_datetime: deployed_datetime)
        return node
    }
}