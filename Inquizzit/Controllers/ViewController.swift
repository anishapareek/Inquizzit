//
//  ViewController.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/1/23.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        
        model.getQuestions()
    }
    
    // MARK: - Quiz Protocol Methods
    func questionsRetrieved(_ questions: [Question]) {
        print("Questions retrieved from model!")
    }
}

