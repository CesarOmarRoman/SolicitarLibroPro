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
    @IBOutlet weak var ImagenPortada: UIImageView!
  
    
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
        let datos = NSData(contentsOf: url! as URL)
        
        if datos != nil {
            
            do {
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let jsonDic = json as! NSDictionary
                
                if jsonDic.allKeys.count == 0 {
                    
                    
                } else {
                    var titleString = ""
                    var authorsString = ""
                    
                    let book = jsonDic["ISBN:\(editarTexto.text!)"] as! NSDictionary
                    
                    if book["title"] != nil {
                        titleString = book["title"] as! NSString as String
                    }
                    
                    if book["authors"] != nil {
                        let authorsArray = book["authors"] as! NSArray
                        for i in 0 ..< authorsArray.count {
                            let a = authorsArray[i] as! NSDictionary
                            if i == 0 {
                                authorsString = a["name"] as! NSString as String
                            } else {
                                authorsString = authorsString + ", " + (a["name"] as! NSString as String)
                            }
                        }
                    }
                    
                    labelTitulo.text = titleString
                    labelAutores.text = authorsString
                    
                    
                    let url = URL(string: "http://covers.openlibrary.org/b/isbn/\(editarTexto.text!)-M.jpg")
                    let data = try? Data(contentsOf: url!)
                    ImagenPortada.image = UIImage(data: data!)
                    
                    
                    
                }
            } catch _ {
                
            }
        } else {
           
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

