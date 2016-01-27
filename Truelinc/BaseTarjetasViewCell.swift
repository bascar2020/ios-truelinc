//
//  BaseTarjetasViewCell.swift
//  Truelinc
//
//  Created by Charlie Molina on 21/01/16.
//  Copyright © 2016 Indibyte. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class BaseTarjetasViewCell: PFTableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var empresa: UILabel!
    @IBOutlet weak var cargo: UILabel!
    @IBOutlet weak var logo: PFImageView!
    @IBOutlet weak var perfil: PFImageView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
