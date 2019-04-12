//
//  VideoInfoTableViewCell.swift
//  Qwerty Systems
//
//  Created by Bhavin Agarwal on 12/04/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class VideoInfoTableViewCell: UITableViewCell {
    
    var videoItem: VideoItem?{
        didSet{
            detailTextLabel?.text = videoItem?.videoDescription
            textLabel?.text = videoItem?.title
            setupVideoImage(videoItem: videoItem)
        }
    }
    
    let videoImage: UIImageView = {
        let videoImage = UIImageView()
        videoImage.image = UIImage(named: "initialProfileImage")
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        videoImage.layer.cornerRadius = 20
        videoImage.layer.masksToBounds = true
        return videoImage
    }()
    
    private func setupVideoImage(videoItem: VideoItem?){
        if let videoThumbnailUrl = videoItem?.thumbnailUrl{
            self.videoImage.loadImageUsingCacheWithUrlString(urlString: videoThumbnailUrl as! String)
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 56, y: (textLabel?.frame.origin.y)!, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        
        detailTextLabel?.frame = CGRect(x: 56, y: (detailTextLabel?.frame.origin.y)!, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(videoImage)
        
        videoImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        videoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        videoImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        videoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
