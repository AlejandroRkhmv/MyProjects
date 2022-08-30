//
//  modelTimeCalculator.swift
//  TimeCalculator
//
//  Created by Александр Рахимов on 28.08.2022.
//

import Foundation
import UIKit

class OperandsCalculation {
    
    var firstOperand = 0
    var secondOperand = 0
    var secondOperandForMultiAndDivisionButtons = 0
    var binaryOperator = ""
    
    private func calculateOperands(hours: Int, minutes: Int, seconds: Int) -> Int {
        
        let temporaryOperand = (hours * 3600) + (minutes * 60) + seconds
        
        return temporaryOperand
    }
    
    public func setFirstOperand(hours: Int, minutes: Int, seconds: Int) {
        
        firstOperand = calculateOperands(hours: hours, minutes: minutes, seconds: seconds)
        
    }
    
    public func setSecondOperand(hours: Int, minutes: Int, seconds: Int) {
        
        secondOperand = calculateOperands(hours: hours, minutes: minutes, seconds: seconds)
        
    }
    
    
    func calculateAnswer() -> [String: Int] {
        
        var resultToresultLabel = ["h": 0, "m": 0, "s": 0]
        var currentResultInSeconds = 0
        
        switch binaryOperator {
        case "+":
            currentResultInSeconds = firstOperand + secondOperand
        case "-":
            currentResultInSeconds = firstOperand - secondOperand
        case "×":
            currentResultInSeconds = firstOperand * secondOperandForMultiAndDivisionButtons
        case "÷":
            currentResultInSeconds = firstOperand / secondOperandForMultiAndDivisionButtons
        default: break
        }
        
        resultToresultLabel["h"] = currentResultInSeconds / 3600
        resultToresultLabel["m"] = (currentResultInSeconds % 3600) / 60
        resultToresultLabel["s"] = (currentResultInSeconds % 3600) % 60
    
        return resultToresultLabel
    }
}
