//
//  ViewController.swift
//  SolicitarLibroPro
//
//  Created by César Omar Román Domínguez on 30/11/16.
//  Copyright © 2016 César Omar Román Domínguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editarTexto: UITextField!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelAutores: UILabel!
    @IBOutlet weak var labelPortada: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        editarTexto.clearButtonMode = UITextFieldViewMode.always
        editarTexto.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
      
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + editarTexto.text!
        let url = URL(string: urls)
        let datos = try! Data(contentsOf: url!)
        
        if datos != nil {
            
            let json = try! JSONSerialization.jsonObject(with: datos)
            let dico1 = json as! NSDictionary
            
            let dico2 = dico1["ISBN:978-84-376-0494-7"] as! NSDictionary
            
            let dico3 = dico2["title"] as! NSString
            
            labelTitulo.text = String(dico3)
            
            print(dico2)
            

       
            
            //self.ciudad.text = String(describing: dico6)
            
            /*
            
            
            
            let dico5 = dico4["name"] as! NSString
            //self.ciudad.text = String(describing: dico6)
            
           
            labelAutores.text = String(dico5)
            */
            

        } else {
            let alertController = UIAlertController(title: "Error", message: "Ha habido un problema conectando con el servidor", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.labelTitulo.text = ""
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }



}

