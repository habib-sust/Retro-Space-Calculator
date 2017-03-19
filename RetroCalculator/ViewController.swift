//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Habibur Rahman on 3/8/17.
//  Copyright © 2017 Habibur Rahman. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var buttonSound: AVAudioPlayer!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var rightValStr = ""
    var LeftValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
        outputLabel.text = "0"
    }
    
    
    
    @IBAction func buttonPressed(sender: UIButton){
        
       playSound()
        
        
        runningNumber += "\(sender.tag)"
        
        outputLabel.text = runningNumber
        
        
        
    }
    
    func playSound(){
        
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
        
    }
    
    
    
    @IBAction func onDividePressd(sender: AnyObject){
        
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressd(sender: AnyObject){
        
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onAddPressd(sender: AnyObject){
        
        processOperation(operation: .Add)
    }
    
    @IBAction func onSubtractPressd(sender: AnyObject){
        
        processOperation(operation: .Subtract)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject){
        
        processOperation(operation: currentOperation)
        
        
    }
    
    @IBAction func onPressdClear(_ sender: Any) {
        
        outputLabel.text = "0"
        
        processOperation(operation: .Empty)
    }
    
    func processOperation(operation: Operation) {
        
        
        if currentOperation != Operation.Empty{
            
            // A user selected an operator , and then selected another operator without first entering a number
            
            if runningNumber != ""{
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    
                    result = "\(Double(LeftValStr)! / Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(LeftValStr)! * Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Add {
                    
                    result = "\(Double(LeftValStr)! + Double(rightValStr)!)"
                    
                }else if currentOperation == Operation.Subtract {
                    
                    result = "\(Double(LeftValStr)! - Double(rightValStr)!)"
                }
                
                
                LeftValStr = result
                outputLabel.text = LeftValStr
                
                }
            
            currentOperation = operation
            
        }else {
            
            // This is the first time an operator has been pressed
            
            LeftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

    


}

