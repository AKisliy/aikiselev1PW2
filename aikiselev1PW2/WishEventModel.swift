//
//  WishEventModel.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 31.01.2024.
//

import Foundation

class WishEventModel{
    let title: String
    let description: String
    let startDate: String
    let endDate: String
    
    init(title: String, description: String, startDate: String, endDate: String) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
