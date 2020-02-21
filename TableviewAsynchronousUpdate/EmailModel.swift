//
//  EmailModel.swift
//  TableviewAsynchronousUpdate
//
//  Created by Bharatraj Rai on 2/16/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation

 class EmailModel: Codable {
    var interactionId: String?
    var subject: String?
    var fromAddress: String?
    var toAddress: String?
    var mlNrnPercentage: Double?
    var isMlypeScoreDataLoaded: Bool?
    
    enum CodingKeys: String, CodingKey {
        case interactionId
        case subject
        case fromAddress = "fromaddress"
        case toAddress = "toaddress"
        case mlNrnPercentage
        case isMlypeScoreDataLoaded
    }
}


class EmailData: Codable {
    var numResults: Int?
    var interactions: [EmailModel]?
}

struct Constants {
    static let placeholderValue = "-"
}
