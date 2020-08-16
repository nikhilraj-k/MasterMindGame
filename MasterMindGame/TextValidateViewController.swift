//
//  TextValidateViewController.swift
//  TextValidator
//
//  Created by Nikhil on 13/08/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import UIKit

class TextValidateViewController: UIViewController {
    @IBOutlet var inputTextFields: [UITextField]!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonReplay: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var buttonCheck: UIButton!
    var getRandomString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setInitialProperties()
    }
    /*Action for the check it will validate input and display output*/
    @IBAction func validateAction(_ sender: Any) {
        guard let randomString = self.getRandomString else {return}
        for tField in inputTextFields where tField.text == "" {
                self.errorLabel.isHidden = false
                return
        }
        for tField in inputTextFields {
            tField.backgroundColor = self.validateAndSetBackgroundColour(tag: tField.tag, text: tField.text ?? "", randomString: randomString)
        }
    }
    /*Action for the button replay. it will reset everything and generate new string**/
    @IBAction func replayAction(_ sender: Any) {
        self.replayClick()
    }
    /*Function for generate a random string and print in console*/
    func generateAndPrindRandomString() {
        self.getRandomString = generateRandomString(length: tRandomStringLenght)
        if let randomString = self.getRandomString {
            print(tRandomStringLog, "\(randomString)")
        }
    }
}

extension TextValidateViewController {
    /*Function for setting initial properties of the screen*/
    func setInitialProperties() {
        self.buttonCheck.titleLabel?.sizeToFit()
        self.buttonCheck.layer.cornerRadius = 5
        self.buttonReplay.setTitle(tReplayButtonTitle, for: .normal)
        self.buttonCheck.setTitle(tCheckButtonTitle, for: .normal)
        self.generateAndPrindRandomString()
        self.errorLabel.text = tInfoText
        self.errorLabel.isHidden = true
        for tField in inputTextFields {
            tField.addTarget(self, action: #selector(changeTextFieldValue), for: .editingChanged)
        }
    }
    /*Function resetting the game and generate new random String*/
    func replayClick() {
        for tField in inputTextFields {
            tField.text = ""
            tField.backgroundColor = .white
        }
        inputTextFields[0].becomeFirstResponder()
        self.generateAndPrindRandomString()
    }
    /*Function for generaing the random string*/
    func generateRandomString(length: Int) -> String {
        let letters = tRandomGeneratorString
        return String((0..<length).map { _ in (letters.randomElement() ?? "T")})
    }
    /*Function for validating the input fields and generaing colour*/
    func validateAndSetBackgroundColour(tag: Int, text: String, randomString: String) -> UIColor {
        if String(randomString[tag]) == text {
            return .green
        } else if randomString.contains(text) {
            return .orange
        } else {
            return .red
        }
    }
    /*Function for getting current input field */
    @objc func changeTextFieldValue(sender: UITextField) {
        switch sender.tag {
        case 0, 1, 2: setTextFieldResponder(sender: sender)
        default:break
        }
    }
     /*Function for change the scope of input field to next one */
    func setTextFieldResponder(sender: UITextField) {
        guard let text = sender.text, text.count == 1 else {
            return
        }
        inputTextFields[sender.tag + 1].becomeFirstResponder()
    }
}

/*Text field delegates*/
extension TextValidateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textField.backgroundColor = .white
        if errorLabel.isHidden == false {
            self.errorLabel.isHidden = true
        }
        /*Limiting the text length*/
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 1
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}
