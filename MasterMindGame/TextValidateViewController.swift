//
//  TextValidateViewController.swift
//  TextValidator
//
//  Created by Sreekanth B on 13/08/20.
//  Copyright © 2020 Sreekanth B. All rights reserved.
//

import UIKit

class TextValidateViewController: UIViewController {
    
    @IBOutlet var inputTextFields: [UITextField]!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonReplay: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var buttonCheck: UIButton!
    
    var getRandomString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setInitialProperties()
        
    }
    
    /*Action for the check it will validate input and display output*/
    @IBAction func validateAction(_ sender: Any) {
        guard let randomString = self.getRandomString else{return}
        for tf in inputTextFields
        {
            if tf.text == ""
            {
                self.errorLabel.isHidden = false
                return
            }
        }
        
        for tf in inputTextFields {
            tf.backgroundColor = self.validateAndSetBackgroundColour(tag: tf.tag, text: tf.text ?? "", randomString: randomString)
        }
        
    }
    /*Action for the button replay. it will reset everything and generate new string**/
    
    @IBAction func replayAction(_ sender: Any) {
        
        for tf in inputTextFields {
            tf.text = ""
            tf.backgroundColor = .white
        }
        inputTextFields[0].becomeFirstResponder()
        self.generateAndPrindRandomString()
    }
    /*Function for generate a random string and print in console*/
    
    func generateAndPrindRandomString()
    {
        self.getRandomString = generateRandomString(length: 4)
        if let randomString = self.getRandomString
        {
            print(randomString)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TextValidateViewController
{
    
    /*Function for setting initial properties of the screen*/
    func setInitialProperties()
    {
        self.buttonCheck.titleLabel?.sizeToFit()
        self.buttonCheck.layer.cornerRadius = 5
        self.generateAndPrindRandomString()
        self.errorLabel.text = tInfoText
        self.errorLabel.isHidden = true
        for tf in inputTextFields{
            tf.addTarget(self, action: #selector(changeTextFieldValue), for: .editingChanged)
        }
    }
    
    /*Function for generaing the random string*/
    func generateRandomString(length: Int) -> String {
        let letters = tRandomGeneratorString
        return String((0..<length).map{ _ in (letters.randomElement() ?? "T")})
    }
    
    /*Function for validating the input fields and generaing colour*/
    func validateAndSetBackgroundColour(tag:Int,text:String,randomString:String) -> UIColor
    {
        if String(randomString[tag]) == text
        {
            return .green
        }
        else if randomString.contains(text)
        {
            return .orange
        }
        else
        {
            return .red
        }
        
    }
    /*Function for getting current input field */
    @objc func changeTextFieldValue(sender : UITextField){
        switch sender.tag {
        case 0,1,2: setTextFieldResponder(sender: sender)
        default:break
        }
    }
     /*Function for change the scope of input field to next one */
    func setTextFieldResponder(sender : UITextField){
        guard let text = sender.text, text.count == 1 else {
            return
        }
        inputTextFields[sender.tag + 1].becomeFirstResponder()
    }
    
}

/*Text field delegates*/
extension TextValidateViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.backgroundColor = .white
        if errorLabel.isHidden == false
        {
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
