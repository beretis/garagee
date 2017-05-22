//
//  ViewController.swift
//  garagee
//
//  Created by Jozef Matus on 17/02/17.
//  Copyright © 2017 Jozef Matus. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: Any) {

    }
    @IBAction func createClicked(_ sender: Any) {

    }

}
//
extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}
