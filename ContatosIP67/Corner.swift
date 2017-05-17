//
//  Corner.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/22/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius : CGFloat{
    get{
        return layer.cornerRadius;
    }
        set{
            layer.cornerRadius = newValue;
            self.clipsToBounds = true;
        }
    }
}
