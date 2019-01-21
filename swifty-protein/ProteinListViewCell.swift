//
//  ProteinListViewCell.swift
//  swifty-protein
//
//  Created by Mi Hwangbo on 1/15/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class ProteinListViewCell: UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
