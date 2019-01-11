//
//  InterViewController.swift
//  CenaNavidad
//
//  Created by IGNACIO GALAN DE PINA on 10/1/19.
//  Copyright © 2019 IGNACIO GALAN DE PINA. All rights reserved.
//

import UIKit

class InterViewController: UIViewController {
    
    internal var guests:[Guest] = []
    internal var dishes:[Dish] = []
    
    convenience init(guests: [Guest], dishes:[Dish]) {
        self.init()
        self.guests = guests
        self.dishes = dishes
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ShowGuests(_ sender: Any) {
        let guestsVC = GuestsViewController()
        navigationController?.pushViewController(guestsVC, animated: true)
    }
    
    @IBAction func ShowDishes(_ sender: Any) {
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
