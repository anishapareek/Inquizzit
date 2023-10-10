//
//  ResultViewController.swift
//  Inquizzit
//
//  Created by Anisha Pareek on 10/9/23.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {

    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var dialogViewBackgroundImage: UIImageView!
    
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate: ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round the dialog box corners
        dialogView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
        // Hide the UI elements
        dimView.alpha = 0
        titleLabel.alpha = 0
        feedbackLabel.alpha = 0
        dismissButton.alpha = 0
        dialogViewBackgroundImage.alpha = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Fade in the elements
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
            self.dimView.alpha = 1
            self.titleLabel.alpha = 1
            self.feedbackLabel.alpha = 1
            self.dismissButton.alpha = 1
            self.dialogViewBackgroundImage.alpha = 0
        }

    }

    @IBAction func dismissTapped(_ sender: Any) {
        
        // Fade out the dim view and then dismiss the popup
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.dimView.alpha = 0
        } completion: { _ in
            
            // Dismiss the pop-up
            self.dismiss(animated: true)
            
            // Notify delegate the popup was dismissed
            self.delegate?.dialogDismissed()
        }
    }
}
