//
//  ViewController.swift
//  Calculator
//
//  Created by Никита on 15.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica-Bold", size: 100)
        return label
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
        
        
        
    }
  

    
    private func setupNumberPad(){
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 3, height: buttonSize))
        
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
            
            button1.setTitleColor(.white, for: .normal)
            button1.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            button1.setTitle("\(x + 1)", for: .normal)
            button1.tag = x+2
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
            
            button2.setTitleColor(.white, for: .normal)
            button2.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            button2.setTitle("\(x + 4)", for: .normal)
            button2.tag = x + 5
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button2)
        }
        
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize, height: buttonSize))
            
            button3.setTitleColor(.white, for: .normal)
            button3.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            button3.setTitle("\(x + 7)", for: .normal)
            button3.tag = x + 8
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
        
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        clearButton.setTitle("Clear All", for: .normal)
        holder.addSubview(clearButton)
        
        let operations = ["=", "+", "-", "x", "/"]
        
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
            
            button4.setTitleColor(.white, for: .normal)
            button4.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            button4.setTitle(operations[x], for: .normal)
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            button4.tag = x+1
            holder.addSubview(button4)
        
        }

        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    @objc func clearResult() {
            resultLabel.text = "0"
            currentOperations = nil
            firstNumber = 0
        }

        @objc func zeroTapped() {

            if resultLabel.text != "0" {
                if let text = resultLabel.text {
                    resultLabel.text = "\(text)\(0)"
                }
            }
        }

        @objc func numberPressed(_ sender: UIButton) {
            let tag = sender.tag - 1

            if resultLabel.text == "0" {
                resultLabel.text = "\(tag)"
            }
            else if let text = resultLabel.text {
                resultLabel.text = "\(text)\(tag)"
            }
        }

        @objc func operationPressed(_ sender: UIButton) {
            let tag = sender.tag

            if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
                firstNumber = value
                resultLabel.text = "0"
            }

            if tag == 1 {
                if let operation = currentOperations {
                    var secondNumber = 0
                    if let text = resultLabel.text, let value = Int(text) {
                        secondNumber = value
                    }

                    switch operation {
                    case .add:

                        let result = firstNumber + secondNumber
                        resultLabel.text = "\(result)"
                        break

                    case .subtract:
                        let result = firstNumber - secondNumber
                        resultLabel.text = "\(result)"

                        break

                    case .multiply:
                        let result = firstNumber * secondNumber
                        resultLabel.text = "\(result)"

                        break

                    case .divide:
                        let result = firstNumber / secondNumber
                        resultLabel.text = "\(result)"
                        break
                    }
                }
            }
            else if tag == 2 {
                currentOperations = .add
            }
            else if tag == 3 {
                currentOperations = .subtract
            }
            else if tag == 4 {
                currentOperations = .multiply
            }
            else if tag == 5 {
                currentOperations = .divide
            }

        }

    }
