//
//  VideoItem.swift
//  Qwerty Systems
//
//  Created by Bhavin Agarwal on 12/04/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import Foundation
import SwiftyJSON

class VideoItem: NSObject {
    var videoId: String?
    var title: String?
    var videoDescription: String?
    var thumbnailUrl: String?
    
    public init?(fromJson: JSON){
        let videoId = fromJson["id"]["videoId"].string
        let videoTitle = fromJson["snippet"]["title"].string
        let decription = fromJson["snippet"]["description"].string
        let thumbnail = fromJson["snippet"]["thumbnails"]["default"]["url"].string
        
        self.videoId = videoId
        self.title = videoTitle
        self.videoDescription = decription
        self.thumbnailUrl = thumbnail
    }
}
