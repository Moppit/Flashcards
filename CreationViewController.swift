//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Michelle Tran on 2/29/20.
//  Copyright © 2020 Michelle Tran. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    @IBOutlet weak var question_field: UITextField!
    @IBOutlet weak var answer_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapOnCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get user input
        let q_text = question_field.text
        let a_text = answer_field.text
        // Update the flashcard
        flashcardsController.updateFlashcard(question: q_text!, answer: a_text!)
        // Dismiss the navigation page
        dismiss(animated: true)
    }
}
