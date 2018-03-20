//
//  ListPostTableViewCell.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import Kingfisher

class ListPostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var commentButton: UIButton!
  @IBOutlet weak var shareButton: UIButton!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet weak var likeCountLabel: UILabel!
  
  
  func configure(with items: Post) {
    
    let url = URL(string: items.user.profilePicture)
    profileImage.kf.setImage(with: url)
    profileImage.circle()
    
    let postImageUrl = URL(string: items.images.lowResolution.url)
    postImage.kf.setImage(with: postImageUrl)
    
    
    likeCountLabel.text = myLike(like: items.likes.count)
    
  }
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK - helper
extension ListPostTableViewCell {
  fileprivate func myLike(like: Int) -> String {
     let mylike = like > 1 ? "\(like) likes" : "\(like) like"
    return mylike
  }
  
}
extension ListPostTableViewCell: NibLoadable {}
extension ListPostTableViewCell: IdentifierReusable {}


