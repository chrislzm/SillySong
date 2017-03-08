//
//  ViewController.swift
//  Silly Song
//
//  Created by Chris Leung on 3/8/17.
//  Copyright © 2017 Chris Leung. All rights reserved.
//

import UIKit

func shortNameFromName(name: String) -> String {
    
    let fullNameChars = name.lowercased().characters
    var shortName = String()
    let vowels = "aeiou"
    var vowelFound = false
    
    // Create a string, with consonants before first vowel found removed
    for char in fullNameChars {
        if(!vowelFound) {
            if vowels.contains(String(char)) {
                vowelFound = true
                shortName.append(char)
            }
        } else {
            shortName.append(char)
        }
    }
    
    // If no vowels were found, return the original full name
    if(!vowelFound) {
        return name.lowercased()
    }
    
    return shortName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    var updatedTemplate = lyricsTemplate
    updatedTemplate = updatedTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    updatedTemplate = updatedTemplate.replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: fullName))
    return updatedTemplate
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// Capitalizes the first letter, lowercases the following letters
func properCapitalization(_ fullName:String) -> String {
    let secondLetterIndex = fullName.index(after: fullName.startIndex)
    return fullName.uppercased().substring(to: secondLetterIndex) + fullName.lowercased().substring(from: secondLetterIndex)
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        
        if !(nameField.text?.isEmpty)! {
            
            let fullName = properCapitalization(nameField.text!)

            nameField.text = fullName
            
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: fullName)
        }
    }
}

