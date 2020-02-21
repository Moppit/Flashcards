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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapOnFlash(_ sender: Any) {
        question_label.isHidden = true
    }
    
}

