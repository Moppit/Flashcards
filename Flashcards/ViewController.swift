//
//  ViewController.swift
//  Flashcards
//
//  Created by Michelle Tran on 2/15/20.
//  Copyright © 2020 Michelle Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var question_label: UILabel!
    @IBOutlet weak var answer_label: UILabel!
    var iterator = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Need to figure out what this does and how it does it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }

    @IBAction func didTapOnFlash(_ sender: Any) {
        // Flip for both sides
        if(iterator % 2 == 0)
        {
            question_label.isHidden = true
        }
        else
        {
            question_label.isHidden = false
        }
        iterator += 1
    }
    
    func updateFlashcard(question: String, answer: String) {
        question_label.text = question
        answer_label.text = answer
    }
    
}

