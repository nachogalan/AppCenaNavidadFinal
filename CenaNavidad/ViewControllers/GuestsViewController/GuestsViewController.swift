//
//  GuestsViewController.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 10/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {
    
    
    
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    internal var guests:[Guest] = []
    internal var repository = LocalGuestRepository()
    
    
    @IBAction func `switch`(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
            tableView.reloadData()
            print(filterSwitch.isOn)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        guests = repository.getAll()
        title = "Participantes"
        // Do any additional setup after loading the view.
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: false)
        
        
        
    }
    

    
    
   
    @objc internal func addPressed() {
        let addGuestVC = AddGuestViewController(guest: nil)
        addGuestVC.delegate = self
        addGuestVC.modalTransitionStyle = .coverVertical
        addGuestVC.modalPresentationStyle = .overCurrentContext
        present(addGuestVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func registerCells(){
        let nib = UINib(nibName: "GuestTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GuestTableViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GuestsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GuestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GuestTableViewCell", for: indexPath) as! GuestTableViewCell
        let guest = guests[indexPath.row]
        cell.lblGuestName.text = guest.name
        cell.imgView.isHidden = !guest.isDone
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = guests[indexPath.row]
        guest.isDone = !guest.isDone
        if repository.update(a: guest) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let guest = guests[indexPath.row]
            if repository.delete(a: guest){
                guests.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
        }
    }
}

extension GuestsViewController: AddGuestViewControllerDelegate {
    func addGuestViewController(_ vc: AddGuestViewController, didEditGuest guest: Guest) {
        vc.dismiss(animated: true, completion: nil)
        if repository.create(a: guest) {
            guests = repository.getAll()
            tableView.reloadData()
        }
    }
}
