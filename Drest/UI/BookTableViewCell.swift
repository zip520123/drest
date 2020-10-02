//
//  BookTableViewCell.swift
//  Drest
//
//  Created by zip520123 on 02/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
  
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
  }
  
}
