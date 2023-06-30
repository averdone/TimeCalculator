//
//  TimeClass.swift
//  TimeCalculator
//
//  Created by Anthony Verdone on 9/2/22.
//

import Foundation
import UIKit

class time{
    var days: Int
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(days: Int, hours: Int, minutes: Int, seconds: Int){
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func printtime(){
        print("Days: \(self.days)\n")
        print("Hours: \(self.hours)\n")
        print("Minutes: \(self.minutes)\n")
        print("Seconds: \(self.seconds)\n")
    }
    
    func ConvertToSeconds(){
        self.seconds += (self.minutes * 60)
        self.seconds += (self.hours * 3600)
        self.seconds += (self.days * 86400)
        (self.minutes, self.hours, self.days) = (0, 0, 0)
    }
    
    
    func MakeAccurate(){
        while((self.hours >= 24) || (self.minutes >= 60) || (self.seconds >= 60)){
            if (self.seconds >= 60){
                self.minutes += 1
                self.seconds -= 60
            }
            else if (self.minutes >= 60){
                self.hours += 1
                self.minutes -= 60
            }
            else if (self.hours >= 24){
                self.days += 1
                self.hours -= 24
            }
        }//end loop
    }
    
    func MakePositive(){
        while((self.hours < 0) || (self.minutes < 0) || (self.seconds < 0)){
            if((self.hours < 0) && (self.minutes < 0) && (self.seconds < 0)){break}
            if (self.seconds < 0){
                self.minutes -= 1
                self.seconds = 60 - (-1 * self.seconds)
            }
            else if (self.minutes < 0){
                self.hours -= 1
                self.minutes = 60 - (-1 * self.minutes)
            }
            else if (self.hours < 0){
                self.days -= 1
                self.seconds = 60 - (-1 * self.seconds)
            }
        }
    }
}



func add(val1:time, val2: time) -> time{
        val1.seconds += val2.seconds
        val1.minutes += val2.minutes
        val1.hours += val2.hours
        val1.days += val2.days
        val1.MakeAccurate()
        return val1
    }

func sub(val1:time, val2:time)->time{ //value 1 - value 2
    val1.seconds -= val2.seconds
    val1.minutes -= val2.minutes
    val1.hours -= val2.hours
    val1.days -= val2.days
    val1.MakeAccurate()
    val1.MakePositive()
    return val1
}

/*func divide(val1:time, val2:time)->time{ //value 1 over value 2
    val1.ConvertToSeconds()
    val2.ConvertToSeconds()
    let result = time(days:0, hours:0, minutes: 0, seconds: (val1.seconds / val2.seconds))
    return result
}*/

func divide(val1:Int, val2:Int)->time{ //divides the amount of val1 (seconds) by val2
    
    if val2 == 0 {
        return time(days:0, hours: 0, minutes: 0, seconds: 0 )
    }
    var RawResult = val1 / val2 // raw value (seconds)
    
    let days = RawResult / 86400
    RawResult = (RawResult - (days * 86400)) //subtracting the amount of days for the rest of the calculations
    
    let hours = RawResult / 3600
    RawResult = (RawResult - (hours * 3600)) //subtracting the amount of hours for the rest of the calculations
    
    let minutes = RawResult / 60
    RawResult = (RawResult - (minutes * 60)) //subtracting the amount of minutes for the rest of the calculations
    //raw result should be the remaining number of seconds at this line
    
    let seconds = RawResult
    
    //create time object to return
    let result = time(days:days, hours: hours, minutes: minutes, seconds: seconds )
    
    return result
}

func mult(val1:time, multiplier: Int)->time{
    val1.seconds *= multiplier
    val1.minutes *= multiplier
    val1.hours *= multiplier
    val1.days *= multiplier
    val1.MakeAccurate()
    return val1
}




	
