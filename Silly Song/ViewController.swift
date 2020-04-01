//
//  ViewController.swift
//  Silly Song
//
//  Created by Kai-Chin Huang on 4/1/20.
//  Copyright © 2020 Kai-Chin Huang. All rights reserved.
//

import UIKit

let bananaFanaTemplate = [
"<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
"Banana Fana Fo F<SHORT_NAME>",
"Me My Mo M<SHORT_NAME>",
"<FULL_NAME>"].joined(separator: "\n")


func shortNameForName(_ name: String)-> String {
    let lowercaseName = name.lowercased()
    let vowelSet = CharacterSet(charactersIn: "aeiou")
    var substring = ""
        
    if let range = lowercaseName.rangeOfCharacter(from: vowelSet){
        let startIndex = range.lowerBound
        
        substring = lowercaseName.substring(from: startIndex)
    }
    
    return substring
    
}

func lyricForName(_ lyricsTemplate: String, _ fullName: String) -> String {
    
    let shortName = shortNameForName(fullName)
    
    //replace the template with full name and short name
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
    
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    

    @IBAction func reset(_ sender: Any) {
        nameField?.text = ""
        lyricsView?.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text?.isEmpty == false {
            print("Name is not empty")
            let lyrics = lyricForName(bananaFanaTemplate, nameField.text!)
            lyricsView?.text = lyrics
            print(lyrics)
        }
        else {
            print("Name is empty")
        }
    }
}

//Add this extension so users can press enter in the text field without us to adding a button
extension ViewController: UITextFieldDelegate {
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return false
       }
   }
