//
//  VideoListTableViewController.swift
//  Qwerty Systems
//
//  Created by Bhavin Agarwal on 12/04/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoListTableViewController: UITableViewController {
    
    private var videoItems = [VideoItem]()
    
    private let cellId = "videoCellId"
    
    func callWebService(webURL urlString: String){
        var url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let taskData = data else{
                print("error fetching")
                return
            }
            
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            let json = JSON(taskData)
//            print(json)
            
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
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
