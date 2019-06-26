//
//  RecipeDescriptionDecodable.swift
//  Reciplease
//
//  Created by Souissi idriss2 on 13/06/2019.
//  Copyright © 2019 Souissi idriss2. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct RecipeDescriptionDecodable: Decodable {
    
    let totalTime: String
    let images: [Image]
    let name: String
    let ingredientLines: [String]
    let rating: Int
    let source: Source
}


// MARK: - Image
struct Image: Decodable {
    let hostedSmallURL, hostedMediumURL, hostedLargeURL: String
    let imageUrlsBySize: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case hostedSmallURL = "hostedSmallUrl"
        case hostedMediumURL = "hostedMediumUrl"
        case hostedLargeURL = "hostedLargeUrl"
        case imageUrlsBySize
    }
}



// MARK: - Unit
struct Unit: Decodable {
    let id: String
    let name: Name
    let abbreviation: Abbreviation
    let plural: Plural
    let pluralAbbreviation: Abbreviation
    let decimal: Bool
}

enum Abbreviation: String, Decodable {
    case g = "g"
    case grams = "grams"
    case iu = "IU"
    case kcal = "kcal"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}

enum Name: String, Decodable {
    case calorie = "calorie"
    case gram = "gram"
    case iu = "IU"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}

enum Plural: String, Decodable {
    case calories = "calories"
    case grams = "grams"
    case iu = "IU"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}

struct Source: Decodable {
    let sourceDisplayName, sourceSiteURL: String
    let sourceRecipeURL: String
    
    enum CodingKeys: String, CodingKey {
        case sourceDisplayName
        case sourceSiteURL = "sourceSiteUrl"
        case sourceRecipeURL = "sourceRecipeUrl"
    }
}


