//
//  AddGuestViewController.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 10/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit

protocol AddGuestViewControllerDelegate: class {
    func addGuestViewController(_ vc: AddGuestViewController, didEditGuest guest: Guest)
}

class AddGuestViewController: UIViewController {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var guest: Guest!
    weak var delegate: AddGuestViewControllerDelegate!
    
    convenience init(guest: Guest?) {
        self.init()
        if guest == nil {
            self.guest = Guest()
            self.guest.isDone = false //No seria necesario
            self.guest.name = UUID().uuidString
            
        }
        else {
            self.guest = guest
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8){
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonPressed() {
        guest.name = textField.text
        delegate.addGuestViewController(self, didEditGuest: guest)
        
    }
    
    
}
