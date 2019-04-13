//
//  VideoPlayerViewController.swift
//  Qwerty Systems
//
//  Created by Bhavin Agarwal on 13/04/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import WebKit

class VideoPlayerViewController: UIViewController {

    var videoUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webV:WKWebView = WKWebView(frame: self.view.frame)
        webV.load(URLRequest(url: URL(string: videoUrl)!))
        self.view.addSubview(webV)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
