//
//  RecipeService.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 24/05/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation


class RecipeService {
    
   
    func downloadImage(with stringUrl: String, session: URLSession = URLSession.shared, callback: @escaping (Data?) -> Void) {
        guard let url = URL(string: stringUrl) else {
            callback(nil)
            return
        }
        session.dataTask(with: url) {(data, _, _) in
            
            guard let data = data else {
                callback(nil)
                return
            }
            DispatchQueue.main.async {
                callback(data)
            }
            
            }.resume()
    }
}
