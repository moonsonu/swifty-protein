//
//  WarningViewController.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/19/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class WarningViewController: UIViewController {

    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var WarningText: UILabel!
    @IBOutlet weak var WarningButton: UIButton!
    
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningView.layer.cornerRadius = 10
        WarningText.layer.cornerRadius = 5
        WarningButton.layer.cornerRadius = 5
        warningView.layer.masksToBounds = true
        WarningText.layer.masksToBounds = true
        WarningButton.layer.masksToBounds = true


        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePop(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        return
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
