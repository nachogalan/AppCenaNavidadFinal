//
//  MainViewController.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 9/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    internal var dinners:[Dinner] = []
    @IBOutlet weak var tableView: UITableView!
    internal var repository = LocalDinnerRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pagina Principal"
        registerCells()
        dinners = repository.getAll()
        
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: false)
    }
    
    @objc internal func addPressed() {
        let addVC = AddViewController(dinner: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func registerCells(){
        let nib = UINib(nibName: "DinnerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DinnerTableViewCell")
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dinners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DinnerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DinnerTableViewCell", for: indexPath) as! DinnerTableViewCell
        let dinner = dinners[indexPath.row]
        cell.lblName.text = dinner.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dinner = dinners[indexPath.row]
            if repository.delete(a: dinner){
                dinners.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dinner = dinners[indexPath.row]
        let interVC = InterViewController(guests: dinner.guests, dishes: dinner.dishes)
        
        navigationController?.pushViewController(interVC, animated: true)
        
    }
    
    
}

extension MainViewController: AddViewControllerDelegate {
    func addViewController(_ vc: AddViewController, didEditDinner dinner: Dinner) {
        vc.dismiss(animated: true, completion: nil)
        if repository.create(a: dinner) {
            dinners = repository.getAll()
            tableView.reloadData()
        }
    }
}
