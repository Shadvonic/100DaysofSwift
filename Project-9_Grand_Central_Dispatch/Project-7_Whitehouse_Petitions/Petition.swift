//
//  Petition.swift
//  Project-7_Whitehouse_Petitions
//
//  Created by Marc Moxey on 4/16/23.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
