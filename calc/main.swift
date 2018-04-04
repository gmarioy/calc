//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = CommandLine.arguments
args.remove(at: 0)

func check(args:[String]) -> Bool {
    
    for (index,value) in args.enumerated(){
        
        if index % 2 == 0{
            
            if(!isInteger(string: value)){
                
                return false
                
            }
            
        }else{
            
            if(value != "x" && value != "/" && value != "%" && value != "+" && value != "-"){
                
                return false
                
            }
            
        }
        
    }
    
    return true
    
}



func isInteger(string: String) -> Bool {
    
    let scan: Scanner = Scanner(string: string)
    
    var val:Int = 0
    
    return scan.scanInt(&val) && scan.isAtEnd
    
}



if(!check(args: args)){
    
    exit(1)
    
}



func calculate(arg1:String, arg2:String, operate:String) -> Int {
    
    switch operate {
        
    case "+":return Int(arg1)! + Int(arg2)!
        
    case "-":return Int(arg1)! - Int(arg2)!
        
    case "x":return Int(arg1)! * Int(arg2)!
        
    case "/":return Int(arg1)! / Int(arg2)!
        
    case "%":return Int(arg1)! % Int(arg2)!
        
    default: return 0
        
    }
    
}



var result = 0

func calc(args:[String]) -> Int {
    
    if args.count == 1{
        
        return Int(args.first!)!
        
    }
    
    while args.count > 1 {
        
        if args.contains("x") || args.contains("/") || args.contains("%"){
            
            for (index,value) in args.enumerated(){
                
                if value == "x" || value == "/" || value == "%"{
                    
                    result = calculate(arg1: args[index - 1], arg2: args[index + 1], operate: value)
                    
                    var tmpArgs = args
                    
                    tmpArgs[index] = String(result)
                    
                    tmpArgs.remove(at: index + 1)
                    
                    tmpArgs.remove(at: index - 1)
                    
                    return calc(args: tmpArgs)
                    
                }
                
            }
            
        }else{
            
            for (index,value) in args.enumerated(){
                
                if value == "+" || value == "-"{
                    
                    result = calculate(arg1: args[index - 1], arg2: args[index + 1], operate: value)
                    
                    var tmpArgs = args
                    
                    tmpArgs[index] = String(result)
                    
                    tmpArgs.remove(at: index + 1)
                    
                    tmpArgs.remove(at: index - 1)
                    
                    return calc(args: tmpArgs)
                    
                }
                
            }
            
        }
        
    }
    
    return result
    
}

print(calc(args: args))

