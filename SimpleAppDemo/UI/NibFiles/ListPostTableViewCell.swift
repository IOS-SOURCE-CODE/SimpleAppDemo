//
//  ListPostTableViewCell.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

class ListPostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
      
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension ListPostTableViewCell: NibLoadable {}
