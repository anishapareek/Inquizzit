//
//  ResultViewController.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/9/23.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissTapped(_ sender: Any) {
        
    }
}
