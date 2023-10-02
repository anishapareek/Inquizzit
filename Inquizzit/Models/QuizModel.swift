//
//  QuizModel.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/2/23.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ questions: [Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        
        // TODO: Fetch the questions
        
        // Notify the delegate of the retrieved questions
        delegate?.questionsRetrieved([Question]())
    }

}
