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
    @IBOutlet weak var card: UIView!
    
    var iterator = 0
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        if flashcards.count == 0 {
            updateFlashcard(question: "What color is the typical female budgie's cere?", answer: "Pink or reddish brown")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    // Need to figure out what this does and how it does it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }

    @IBAction func didTapOnFlash(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            // Flip for both sides
            if(self.iterator % 2 == 0)
            {
                self.question_label.isHidden = true
            }
            else
            {
                self.question_label.isHidden = false
            }
            self.iterator += 1
        })
    }
    
    // Animation Functions
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion:{ finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    func animateCardOutPrev(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion:{ finished in
            self.updateLabels()
            self.animateCardInPrev()
        })
    }
    func animateCardInPrev(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        
        currentIndex = flashcards.count - 1
        print("Added new flashcard! Current index: \(currentIndex)")
        print("We now have \(flashcards.count) flashcards")
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        question_label.text = currentFlashcard.question
        answer_label.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        //updateLabels()
        animateCardOutPrev()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        animateCardOut()
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

