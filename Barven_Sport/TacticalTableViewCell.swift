//
//  TacticalTableViewCell.swift
//  Barven_Sport
//
//  Created by Nguyễn Minh Hiếu on 5/27/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class TacticalTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_tactical: UILabel!
    
    weak var parentVC : PositionViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            lbl_tactical.textColor = #colorLiteral(red: 1, green: 0.4199104905, blue: 0, alpha: 1)
        }
        else {
            lbl_tactical.textColor = #colorLiteral(red: 0.3790209889, green: 0.3790912032, blue: 0.3790165782, alpha: 1)
        }
        // Configure the view for the selected state
    }

}
