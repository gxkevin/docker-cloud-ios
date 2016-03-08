//
//  NodeViewController.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import UIKit

class NodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cloudClient = CloudClient(userName: "khoigeeky", apiKey: "713068be-df30-4361-8a78-821b9a946bc1")
        cloudClient.getNodes { (nodes) -> () in
            guard let nodes = nodes else {
                print("No nodes found")
                return
            }
            print(nodes)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
