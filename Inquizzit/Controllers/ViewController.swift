//
//  ViewController.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/1/23.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    var resultDialog: ResultViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializa the result dialog
        resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        
        // Set self as the delegate for the Result view controller protocol
        resultDialog?.delegate = self
        
        // Set self as the delegate and datasource for the tableview
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        
        // Dynamic row heights
        optionsTableView.estimatedRowHeight = 100
        optionsTableView.rowHeight = UITableView.automaticDimension
        
        // Set up the model
        model.delegate = self
        model.getQuestions()
        
    }
    
    func displayQuestion() {
        
        // Check if there are questions and check that the currentQuestionIndex is not out of bounds
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            return
        }
        
        // Display the question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        // Reload the table view
        optionsTableView.reloadData()
    }
    
    // MARK: - Quiz Protocol Methods
    func questionsRetrieved(_ questions: [Question]) {
        
        // Get a reference to the questions
        self.questions = questions
        
        // Display the first question
        displayQuestion()
    }
}

extension ViewController: ResultViewControllerProtocol {
    
    func dialogDismissed() {
        
        // Increment the currentQuestionIndex
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count {
            
            // The user has just answered the last question
            // Show a summary dialog
            if let resultDialog {
                
                // Customize the dialog text
                resultDialog.titleText = "Summary"
                resultDialog.feedbackText = "You got \(numCorrect) correct out of \(questions.count) questions"
                resultDialog.buttonText = "Restart"
                present(resultDialog, animated: true)
            }
        }
        else if currentQuestionIndex > questions.count {
            
            // Restart
            numCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
        }
        else if currentQuestionIndex < questions.count {
            
            // We have more questions to show
            // Display the next question
            displayQuestion()
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Make sure that the questions array actually contains at least a question
        guard questions.count > 0 else {
            return 0
        }
        
        // Return the number of answers for this question
        let currentQuestion = questions[currentQuestionIndex]
        
        if let answers = currentQuestion.answers {
            return answers.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // Customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if let label {
            
            let question = questions[currentQuestionIndex]
            
            if let answers = question.answers, indexPath.row < answers.count {
                
                // Set the answer text for the label
                label.text = answers[indexPath.row]
            }
        }
        
        // Return the cell
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titleText = ""
        
        // User has tapped on a row, check if it's the right answer
        let question = questions[currentQuestionIndex]
        
        if let correctAnswerIndex = question.correctAnswerIndex {
            if indexPath.row == correctAnswerIndex {
                
                // User got it right
                titleText = "Correct!"
                numCorrect += 1
            }
            else {
                
                // User got it wrong
                titleText = "Wrong!"
            }
            
            // Show the pop-up
            if let resultDialog {
                
                // Customize the dialog text
                resultDialog.titleText = titleText
                resultDialog.feedbackText = question.feedback ?? ""
                resultDialog.buttonText = "Next"
                present(resultDialog, animated: true)
            }

        }
        else {
            fatalError("ERROR: The correct answer index parameter is nil")
        }

    }
}
