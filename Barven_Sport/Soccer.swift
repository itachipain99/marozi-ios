//
//  Soccer.swift
//  Barven_Sport
//
//  Created by Nguyễn Minh Hiếu on 6/3/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class Soccer {
    var location : CGRect?
    var center : CGPoint?
    var name : UIStackView?
    
    init(_ name : UIStackView) {
        self.name = name
        self.location = name.frame
        self.center = name.center
    }
}
