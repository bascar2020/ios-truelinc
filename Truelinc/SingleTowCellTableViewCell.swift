//
//  SingleTowCellTableViewCell.swift
//  Truelinc
//
//  Created by Charlie Molina on 27/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit

class SingleTowCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lb_empresa: UILabel!
    @IBOutlet weak var lb_nombre: UILabel!
    @IBOutlet weak var lb_cargo: UILabel!
    
    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var img_foto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.img_logo.layer.cornerRadius = img_logo.frame.size.width/2
        self.img_logo.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
