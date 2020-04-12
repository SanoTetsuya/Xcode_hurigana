//
//  ViewController.swift
//  hurigana
//
//  Created by 佐野哲也 on 2020/04/12.
//  Copyright © 2020 佐野哲也. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    var  inputText: String!
    @IBOutlet var outputText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func input(_ sender: Any) {
    }
    
    @IBAction func test(_ sender: Any) {
        inputText = textField.text!
        outputText.text = inputText
        print(inputText)
    }
    
}

