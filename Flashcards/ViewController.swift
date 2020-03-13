//
//  ViewController.swift
//  Flashcards
//
//  Created by Michelle Tran on 2/15/20.
//  Copyright © 2020 Michelle Tran. All rights reserved.
//

import UIKit

// Flashcard struct
struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var question_label: UILabel!
    @IBOutlet weak var answer_label: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var iterator = 0
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateFlashcard(question: "What color is the typical female budgie's cere?", answer: "Pink or reddish brown")
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
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        
        currentIndex = flashcards.count - 1
        print("Added new flashcard! Current index: \(currentIndex)")
        print("We now have \(flashcards.count) flashcards")
        
        updateNextPrevButtons()
        updateLabels()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        question_label.text = currentFlashcard.question
        answer_label.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons() {
            print("Update Next Called")
            // Toggle enable/disable for next button
            if (currentIndex == flashcards.count - 1) {
                nextButton.isEnabled = false
            }
            else {
                nextButton.isEnabled = true
            }
            // Toggle enable/disable for prev button
            if (currentIndex == 0) {
                prevButton.isEnabled = false
            }
            else {
                prevButton.isEnabled = true
            }
        }
    
}

