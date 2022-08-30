//
//  ViewController.swift
//  TimeCalculator
//
//  Created by Александр Рахимов on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {

    let model = OperandsCalculation()
    
    let maxLengthResultLabelText = 19
    let possibleNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var freeLabel = false
    
    var hourButtonDidPressed = false
    var minuteButtonDidPressed = false
    var secondButtonDidPressed = false
    
    var plusMinusButton = false
    var multiDivisionButton = false
    
    var hoursNumber = 0
    var minuteNumber = 0
    var secondNumber = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var hmsButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        let number = sender.titleLabel?.text
        
        if (resultLabel.text?.count)! < maxLengthResultLabelText {
            if freeLabel {
                resultLabel.text! += number!
            } else {
                resultLabel.text = number
                freeLabel = true
            }
        }
    }
    
    func endIndexIsNumber() -> Bool {
        
        let endIndexCharacter = resultLabel.text?.index(before: (resultLabel.text?.endIndex)!)
        let endCharacter = resultLabel.text![endIndexCharacter!]
        
        return possibleNumbers.contains(String(endCharacter))
    }
    
    @IBAction func hourButtonPressed(_ sender: UIButton) {
        
        let hourTitle = sender.titleLabel?.text
        
        if (resultLabel.text?.count)! < maxLengthResultLabelText && endIndexIsNumber() {
            if freeLabel && !hourButtonDidPressed && !minuteButtonDidPressed && !secondButtonDidPressed {
                resultLabel.text! += hourTitle!
                hourButtonDidPressed = true
            }
        }
    }
    
    @IBAction func minuteButtonPressed(_ sender: UIButton) {
        let minuteTitle = sender.titleLabel?.text
        
        if (resultLabel.text?.count)! < maxLengthResultLabelText && endIndexIsNumber() {
            if freeLabel && !minuteButtonDidPressed && !secondButtonDidPressed {
                resultLabel.text! += minuteTitle!
                minuteButtonDidPressed = true
            }
        }
    }
    
    
    @IBAction func secondButtonPressed(_ sender: UIButton) {
        let secondTitle = sender.titleLabel?.text
        
        if (resultLabel.text?.count)! < maxLengthResultLabelText && endIndexIsNumber() {
            if freeLabel && !secondButtonDidPressed {
                resultLabel.text! += secondTitle!
                secondButtonDidPressed = true
            }
        }
    }
    
    func calculatedHoursMinutesAndSeconds() {
        if hourButtonDidPressed {
            let hoursValue = resultLabel.text!.components(separatedBy: "h")
            hoursNumber = Int((hoursValue.first)!) ?? 0
            if hoursValue.count == 2 {
                if minuteButtonDidPressed {
                    let minutesValue = hoursValue[1].components(separatedBy: "m")
                    minuteNumber = Int((minutesValue.first)!) ?? 0
                    if minutesValue.count == 2 {
                        if secondButtonDidPressed {
                            let secondValue = minutesValue[1].components(separatedBy: "s")
                            secondNumber = Int((secondValue.first)!) ?? 0
                        }
                    }
                } else {
                    minuteNumber = 0
                        let secondValue =  hoursValue[1].components(separatedBy: "s")
                        secondNumber = Int(secondValue.first!) ?? 0
                }
            }
        } else {
            hoursNumber = 0
            if minuteButtonDidPressed {
                let minutValue = resultLabel.text!.components(separatedBy: "m")
                minuteNumber = Int(minutValue.first!) ?? 0
                if minutValue.count == 2 {
                    if secondButtonDidPressed {
                        let secondValue = minutValue[1].components(separatedBy: "s")
                        secondNumber = Int(secondValue.first!) ?? 0
                    } else {
                        secondNumber = 0
                    }
                }
            } else {
                minuteNumber = 0
                if secondButtonDidPressed {
                    let secondValue = resultLabel.text!.components(separatedBy: "s")
                    secondNumber = Int(secondValue.first!) ?? 0
                } else {
                    secondNumber = 0
                }
            }
        }
    }
    
    func createSecondOperandForMultiAndDivisionButtons() {
        
        model.secondOperandForMultiAndDivisionButtons = Int(resultLabel.text!)!
    }
    
    @IBAction func twoOperandsButton(_ sender: UIButton) {
        
        plusMinusButton = true
        model.binaryOperator = (sender.titleLabel?.text)!
        
        calculatedHoursMinutesAndSeconds()
        
        print(hoursNumber)
        print(minuteNumber)
        print(secondNumber)
        
        model.setFirstOperand(hours: hoursNumber, minutes: minuteNumber, seconds: secondNumber)
        print(model.firstOperand)
        //let firstOperandTextForLabel = resultLabel.text!
        
        hoursNumber = 0
        minuteNumber = 0
        secondNumber = 0
        resultLabel.text = "00h00m00s"
        freeLabel = false
        
        hourButtonDidPressed = false
        minuteButtonDidPressed = false
        secondButtonDidPressed = false
    }
    
    @IBAction func multiAndDivisButtonsPresed(_ sender: UIButton) {
        
        makeHMSButtonsEnabled(isEnabled: false)
        
        multiDivisionButton = true
        model.binaryOperator = (sender.titleLabel?.text)!
        
        calculatedHoursMinutesAndSeconds()
        
        print(hoursNumber)
        print(minuteNumber)
        print(secondNumber)
        
        model.setFirstOperand(hours: hoursNumber, minutes: minuteNumber, seconds: secondNumber)
        print(model.firstOperand)
        
        hoursNumber = 0
        minuteNumber = 0
        secondNumber = 0
        resultLabel.text = "0"
        freeLabel = false
    }
    
    
    @IBAction func equalButton(_ sender: UIButton) {
        
        if plusMinusButton {
            calculatedHoursMinutesAndSeconds()
            
            print(hoursNumber)
            print(minuteNumber)
            print(secondNumber)
            
            model.setSecondOperand(hours: hoursNumber, minutes: minuteNumber, seconds: secondNumber)
            
            print(model.secondOperand)
            
            let result = model.calculateAnswer()
            
            resultLabel.text = "\(result["h"]!)h\(result["m"]!)m\(result["s"]!)s"
        } else {
            model.secondOperandForMultiAndDivisionButtons = Int(resultLabel.text!)!
            print(model.secondOperandForMultiAndDivisionButtons)
            
            let result = model.calculateAnswer()
            
            resultLabel.text = "\(result["h"]!)h\(result["m"]!)m\(result["s"]!)s"
            
            makeHMSButtonsEnabled(isEnabled: true)
        }
        
        hourButtonDidPressed = false
        minuteButtonDidPressed = false
        secondButtonDidPressed = false
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        hoursNumber = 0
        minuteNumber = 0
        secondNumber = 0
        resultLabel.text = "00h00m00s"
        freeLabel = false
        
        hourButtonDidPressed = false
        minuteButtonDidPressed = false
        secondButtonDidPressed = false
        
        makeHMSButtonsEnabled(isEnabled: true)
    }
    
    @IBAction func deleteLastSymbol(_ sender: UIButton) {
        
        if resultLabel.text!.count > 1 && freeLabel {
            
            let endStringIndex = resultLabel.text!.index(before: (resultLabel.text!.endIndex))
            let endCharacter = resultLabel.text!.remove(at: endStringIndex)
            
            switch endCharacter {
            case "h":
                hourButtonDidPressed = false
            case "m":
                minuteButtonDidPressed = false
            case "s":
                secondButtonDidPressed = false
            default: break
            }
        } else if resultLabel.text!.count == 1 {
            resultLabel.text = "00h00m00s"
            
            hoursNumber = 0
            minuteNumber = 0
            secondNumber = 0
            resultLabel.text = "00h00m00s"
            freeLabel = false
            
            hourButtonDidPressed = false
            minuteButtonDidPressed = false
            secondButtonDidPressed = false
        }
    }
 
    
    private func makeHMSButtonsEnabled(isEnabled: Bool) {
        for button in hmsButtons {
            button.isEnabled = isEnabled
        }
    }
}

