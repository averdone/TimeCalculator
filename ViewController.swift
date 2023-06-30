//
//  ViewController.swift
//  TimeCalculator
//
//  Created by Anthony Verdone on 8/23/22.
//

import UIKit

class ViewController:
    UIViewController {
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    
    var CurrentValue = ""
    let ColonIndexes = [2, 4, 7]
    var startVal: Int! = 0
    var PerformingMD: Bool = false
    var operation = "+"
    
    var val1: time!
    var val2: time!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Begin")
        //ResultLabel.attributedPlaceholder = "00:00:00:00"
        // Do any additional setup after loading the view.
    }


    
    @IBAction func NumberButtonPress(_ sender: UIButton) {
        if(ResultLabel.text! == nil){
            ResultLabel.textColor = UIColor.gray
        }
        if((0...9).contains(sender.tag)){ //if this is a number button, add to label
            
            if( ResultLabel.text!.count == 11){ // if the label has reached its max length (11)
                ResultLabel.blink() //blink
            }
            
            else{
            
            CurrentValue += "\(sender.tag)" // update the current value string
            ResultLabel.text! = formatLabel(str: CurrentValue)//format the string to include colons and set as the label
            }
            
        }

        
    }

    @IBAction func Delete(_ sender: UIButton) {
        //ResultLabel.text! = String(ResultLabel.text!.dropLast())//delete last item
        if(ResultLabel.text == ""){
        }
        else{
            CurrentValue.popLast()//delete last item
            ResultLabel.text! = formatLabel(str: CurrentValue)//format the string to include colons and set as the label
        }
    }
    
    
    @IBAction func Clear(_ sender: UIButton) {
        CurrentValue = ""
        ResultLabel.text! = ""
        print()
    }
    
    
    @IBAction func AddButton(_ sender: UIButton) {
        
        if(ResultLabel.text == ""){
            val1 = time(days: 00, hours: 00, minutes: 00, seconds: 00)
            //val1.printtime()
            operation = "+"
            ResultLabel.text = ""
            CurrentValue = ""
        }
        
        else{
            val1 = GetValues(str: ResultLabel.text!)
            //val1.printtime()
            operation = "+"
            ResultLabel.text = ""
            CurrentValue = ""
        }
    }
    
    @IBAction func SubButton(_ sender: UIButton) {
        if(ResultLabel.text == ""){
            val1 = time(days: 00, hours: 00, minutes: 00, seconds: 00)
            //val1.printtime()
            operation = "-"
            ResultLabel.text = ""
            CurrentValue = ""
        }
        
        else{
            val1 = GetValues(str: ResultLabel.text!)
            //val1.printtime()
            operation = "-"
            ResultLabel.text = ""
            CurrentValue = ""
        }
    }
    
    
    @IBAction func MultButton(_ sender: UIButton) {
        if(ResultLabel.text == ""){
            val1 = time(days: 00, hours: 00, minutes: 00, seconds: 00)
            //val1.printtime()
            operation = "*"
            PerformingMD = true
            ResultLabel.text = ""
            CurrentValue = ""
        }
        
        else{
            val1 = GetValues(str: ResultLabel.text!)
            //val1.printtime()
            operation = "*"
            PerformingMD = true
            ResultLabel.text = ""
            CurrentValue = ""
        }
    }
    
    @IBAction func DivButton(_ sender: UIButton) {
        if(ResultLabel.text == ""){
            val1 = time(days: 00, hours: 00, minutes: 00, seconds: 00)
            //val1.printtime()
            operation = "/"
            PerformingMD = true
            ResultLabel.text = ""
            CurrentValue = ""
        }
        
        else{
            val1 = GetValues(str: ResultLabel.text!)
            //val1.printtime()
            operation = "/"
            PerformingMD = true
            ResultLabel.text = ""
            CurrentValue = ""
        }
    }
    
    @IBAction func equals(_ sender: Any) {
        //val2.printtime()
        PerformingMD = false
        
        if(ResultLabel.text == ""){val1 = time(days: 00, hours: 00, minutes: 00, seconds: 00)}
        
        switch operation{
        case "+":
            val2 = GetValues(str: ResultLabel.text!)
            if val2 == nil{ val2 = time(days: 00, hours: 00, minutes: 00, seconds: 00) }
            let result = add(val1: val1, val2: val2)
            result.printtime()
            ResultLabel.text = formatReturn(t: result)
        case "-":
            val2 = GetValues(str: ResultLabel.text!)
            if val2 == nil{ val2 = time(days: 00, hours: 00, minutes: 00, seconds: 00) }
            let result = sub(val1: val1, val2: val2)
            ResultLabel.text = formatReturn(t: result)
            
        case "*":
            let factor: Int! = Int(ResultLabel.text!)
            let result = mult(val1: val1, multiplier: factor)
            ResultLabel.text = formatReturn(t: result)
             
        case "/":
            let denominator: Int! = Int(ResultLabel.text!)
            val1.ConvertToSeconds()
            let numerator = val1.seconds
            let result = divide(val1: numerator, val2: denominator)
            ResultLabel.text = formatReturn(t: result)
            
        default:
            ResultLabel.text = "ERR"
        }
        
    }




    func GetValues(str: String)->time{
        if(str == ""){ return time(days: 00, hours: 00, minutes: 00, seconds: 00) } //error catch
        let arr = str.components(separatedBy: ":")
        print("get values: \(str)")
        var vals = arr.map{Int($0)!}
        if arr.count < 4 {
            let numZeros = 4 - arr.count
            for x in stride(from: 0, to: numZeros, by: 1){
                vals.insert(00, at:x)
            }
        }
        let timeObj = time(days: vals[0], hours: vals[1], minutes: vals[2], seconds: vals[3])
        timeObj.printtime()
        return timeObj
    }


    func formatReturn(t: time)->String{
        let arr = [t.days, t.hours, t.minutes, t.seconds]
        var x = arr.map{String($0)}
        for y in 0...3{
            if(x[y].count == 1){
                x[y] = "0" + x[y]
            }
        }
        let str = x.joined(separator: ":")
        return str
    }

    func formatLabel(str: String)->String{ // uses the seperate function to add : every 2 elements
        if(PerformingMD){
            return str
        }
        
        var mutStr = String(str.reversed())//needs to be reversed since seconds is int the front
        mutStr = mutStr.separate(every: 2, with: ":")
        mutStr = String(mutStr.reversed())//reverse back to put into label form
        return mutStr
    }
}
extension UIView{
    func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}

extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}

