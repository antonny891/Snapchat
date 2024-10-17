//
//  ViewController.swift
//  MamanchuraAlccaSnapchat
//
//  Created by Antonny Mmamanchura Alcca on 16/10/24.
//

import UIKit
import FirebaseAuth

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password:
            passwordTextField.text!) { (user, error) in
            print ("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presento el siguient error: \(error)")
            }else{
                print("Inicio de sesion exitoso")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

