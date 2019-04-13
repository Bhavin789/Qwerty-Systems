//
//  VideoListTableViewController.swift
//  Qwerty Systems
//
//  Created by Bhavin Agarwal on 12/04/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVKit

class VideoListTableViewController: UITableViewController {
    
    private var videoItems = [VideoItem]()
    
    private let cellId = "videoCellId"
    
    func callWebService(webURL urlString: String){
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let taskData = data else{
                print("error fetching")
                return
            }
            
            if error != nil{
                print(error?.localizedDescription ?? "Error Fetching videos...")
                return
            }
            
            let json = JSON(taskData)
            let items = json["items"].arrayValue
            print(items[0])
            
            for item in items{
                let videoItem = VideoItem(fromJson: item)
                self.videoItems.append(videoItem!)
            }
            
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
        task.resume()
    }
    
    func fetchVideoList(){
        let videoItemURL = "https://www.googleapis.com/youtube/v3/search?order=date&part=snippet&channelId=UCsUMcnDeIrOYKRSybB1yq2Q&maxResults=30&key=AIzaSyAdcqx0IjC2uNSccq1v_YRx8IGD5gmEvNg"
        callWebService(webURL: videoItemURL)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Qwerty Systems"
        navigationController?.navigationBar.barTintColor = UIColor.red
        tableView.register(VideoInfoTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchVideoList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? VideoInfoTableViewCell
        
        let videoItem = videoItems[indexPath.row]
        cell?.videoItem = videoItem
        // Configure the cell...

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoItem = videoItems[indexPath.row]
        
        print(videoItem.getYoutubeVideoLink())
        
        let videoPlayerViewController = VideoPlayerViewController()
        videoPlayerViewController.videoUrl = videoItem.getYoutubeVideoLink()
        
        navigationController?.pushViewController(videoPlayerViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
