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
        
        // Fetch the questions
        getLocalJsonFile()
    }
    
    func getLocalJsonFile() {
        
        // Get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard let path else {
            print("Couldn't find the json data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(filePath: path)
        
        do {
            // Get the data from the url
            let data = try Data(contentsOf: url)
            
            // Try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed object
            delegate?.questionsRetrieved(array)
        } catch {
            // Error: Couldn't download the data at that URL
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getRemoteJsonFile() {
        
    }

}
