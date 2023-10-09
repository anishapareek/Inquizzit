//
//  Question.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/2/23.
//

import Foundation

struct Question: Decodable {
    
    var question: String?
    var answers: [String]?
    var correctAnswerIndex: Int?
    var feedback: String?
}
