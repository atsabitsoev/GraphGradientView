//
//  ViewController.swift
//  GraphGradientView
//
//  Created by Ацамаз Бицоев on 27/04/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var graphGradientView: GraphGradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphGradientView.values = [12,13,28,6,6.5,3,12]
    }


}

