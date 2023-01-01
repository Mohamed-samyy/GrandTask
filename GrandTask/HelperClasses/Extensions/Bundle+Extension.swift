//
//  Bundle+Extension.swift
//  shoqir
//
//  Created by Mohamed Samy on 3/23/20.
//  Copyright © 2020 Mohamed Samy. All rights reserved.
//

import UIKit

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
