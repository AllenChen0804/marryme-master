//
//  FinialViewController.swift
//  marryme
//
//  Created by 陳永展 on 2019/8/2.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class FinialViewController: UIViewController {

    @IBOutlet weak var FinialScoreLabel: UILabel!
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(result!.info)
        FinialScoreLabel.text = String(result!.info)
        
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
