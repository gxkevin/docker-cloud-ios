//
//  Node.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

struct Node{
    let cpu: Int
    let current_num_containers: Int
    let disk: Double
    let external_fqdn: String
    let last_seen: NSDate
    let memory: Double
    let nickname: String
    let public_ip: String?
    let state: String
    let uuid: String
    let node_cluster: String?


    init(cpu: Int, current_num_containers: Int, disk: Double, external_fqdn: String, last_seen: NSDate, memory: Double, nickname: String, state: String, uuid: String, node_cluster: String? = nil, public_ip: String?){
        self.cpu                    = cpu
        self.current_num_containers = current_num_containers
        self.disk                   = disk
        self.external_fqdn          = external_fqdn
        self.last_seen              = last_seen
        self.memory                 = memory
        self.nickname               = nickname
        self.public_ip              = public_ip
        self.state                  = state
        self.uuid                   = uuid
        self.node_cluster           = node_cluster
    }
    
}


struct NodeParser : JSONParserType {
    func parseJSON(json: JSONDictionary) -> Node? {
        guard let   cpu                    = json["cpu"] as? Int,
                    current_num_containers = json["current_num_containers"] as? Int,
                    disk                   = json["disk"] as? Double,
                    external_fqdn          = json["external_fqdn"] as? String,
                    last_seen              = json["last_seen"] as? String,
                    last_seen_date         = CloudDateParser().dateFromString(last_seen),
                    memory                 = json["memory"] as? Double,
                    nickname               = json["nickname"] as? String,
                    state                  = json["state"] as? String,
                    uuid                   = json["uuid"] as? String else{
            return nil
        }
        
        let public_ip    = json["public_ip"] as? String
        let node_cluster = json["node_cluster"] as? String
        return Node(cpu: cpu, current_num_containers: current_num_containers, disk: disk, external_fqdn: external_fqdn, last_seen: last_seen_date, memory: memory, nickname: nickname, state: state, uuid: uuid, node_cluster: node_cluster, public_ip: public_ip)
        
    }
}