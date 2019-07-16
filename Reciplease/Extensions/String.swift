//
//  String.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 12/07/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation

extension String {
    var data: Data? {
        guard let url = URL(string: self) else {return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
