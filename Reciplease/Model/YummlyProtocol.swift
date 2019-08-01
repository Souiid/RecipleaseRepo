//
//  yummlyProtocol.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 15/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation
import Alamofire

protocol YummlyProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension YummlyProtocol {
    var urlStringApi: String {
        let urlString = "http://api.yummly.com/v1/api/recipes?_app_id=1194d937&_app_key=99a9bce6fce64237da219a02352282b9&allowedIngredient%5B%5D=lemon"
        return urlString
    }
}
