//
//  Category.swift
//  letsCook!
//
//  Created by Doris Darwich on 21/04/2019.
//  Copyright © 2019 Lea Charara. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable
{

    case Appetizer
    case Salad
    case Sandwich
    case Burger
    case Pizza
    case Light
    case Platter
    case BBQ
    
    static func allValues() -> [String]
    {
        return Category.allCases.map { $0.rawValue }.sorted(by: <)
    }
}
