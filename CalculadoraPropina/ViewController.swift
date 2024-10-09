//
//  ViewController.swift
//  CalculadoraPropina
//
//  Created by Diana Nicolas on 08/10/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // bill
    @IBOutlet weak var billInput: UITextField!
    
    // Tip selection
    @IBOutlet weak var tipInput: UISegmentedControl!
    
    // Calculate
    @IBOutlet weak var calculate: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate actions to view
        billInput.delegate = self
        
        // disable button
        calculate.isEnabled = false
        
        // set target to receive actions and set action to do
        billInput.addTarget(self, action: #selector(billFilled), for: .editingChanged)
    }
    
    @objc func billFilled(){
        
        // input contains only decimal numbers
        if let billInput = billInput.text, !billInput.isEmpty, billInput.contains(/[0-9]+([\.][0-9])*/) {
            calculate.isEnabled = true
        }
        
        // input is empty
        if let billInput = billInput.text, billInput.isEmpty {
            calculate.isEnabled = false
        }
        
        // input contains letters
        if let billInput = billInput.text, billInput.contains(/[a-zA-z]+/) {
            calculate.isEnabled = false
            // Crear y mostrar alerta
            sendAlert()
        }
        
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        // Due to the conditions in billfilled, if the button
        // is enabled we can always press button calculate
        // safely
        performSegue(withIdentifier: "Calculate", sender: self)
    }
    
    // Sobre escribimos la función para enviar los datos al siguiente
    // controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // verificamos que sea sólo para el segue Calculate
        if segue.identifier == "Calculate" {
            
            if let resultViewController = segue.destination as? ResultViewController {
                
                // la siguiente accion es segura por las condiciones
                // al habilitar el boton
                resultViewController.billValue = Double(billInput.text!)!
                resultViewController.selectedTip = Int(tipInput.selectedSegmentIndex)
                
            }
            
        }
    }
    
    private func sendAlert() {
        let alert = UIAlertController(title: "Error", message: "Bill can only contain numbers", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
    
    
    


}

