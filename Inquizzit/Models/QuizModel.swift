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
        getRemoteJsonFile()
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
        
        // Get a URL object
        let urlString = "https://anishapareek.github.io/Inquizzit-data/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard let url else {
            print("Couldn't create the URL object")
            return
        }
        
        // Get a URL Session object
        let session = URLSession.shared
        
        // get a data task object
        let dataTask = session.dataTask(with: url) { data, response, error in
            
            // Check that there wasn't an error
            if error != nil {
                print("Couldn't fetch the response from the network")
                return
            }
            
            if let data {
                
                // Create a JSON decoder object
                let decoder = JSONDecoder()
                
                do {
                    // Parse the JSON
                    let questions = try decoder.decode([Question].self, from: data)
                    
                    // Use the main thread to notify the view controller for UI work
                    DispatchQueue.main.async {
                        
                        // Notify the delegate
                        self.delegate?.questionsRetrieved(questions)
                    }
                }
                catch {
                    print("Couldn't parse JSON")
                }
            }
            
        }
        
        // call resume on the data task
        dataTask.resume()
    }

}
