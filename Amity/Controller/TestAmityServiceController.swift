//
//  TestAmityServiceController.swift
//  Amity
//
//  Created by Jing Tang on 22/11/2014.
//  Copyright (c) 2014 Jingyu Soft. All rights reserved.
//

import Foundation

class TestAmityServiceControll : UIViewController {
    
    @IBOutlet weak var ResultTextBox: UITextField!
    override func loadView() {
        
        var transport = TSocketClient(hostname: "jingyusoft.com", port: 8531)
        var frameTransport = TFramedTransport(transport:transport)
        var tBinaryProtocol = TBinaryProtocol(transport: frameTransport, strictRead: true, strictWrite: true)
        let serviceClient = AmityServiceClient(inProtocol: tBinaryProtocol, outProtocol: tBinaryProtocol)
        var result = serviceClient.echo("hello kitty")
        if(result == "hello kitty"){
            ResultTextBox.text = "Succeed"
        }
        else{
            ResultTextBox.text = "Failed"
        }
    }
}
