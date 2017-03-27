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
    
    lazy var frc: NSFetchedResultsController<Mamrd.T> = {
        var fetchRequest: NSFetchRequest<Mamrd.T> = NSFetchRequest(entityName: Mamrd.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let fr = NSFetchedResultsController<Mamrd.T>(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fr
    } ()
    
    private var test: Mamrd!

    override func viewDidLoad() {
        super.viewDidLoad()
        try? self.frc.performFetch()
        self.frc.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: Any) {
//        let newZmrdWithTheSameId = Zmrd(id: "zmrdicek", value: "hahahhaha")
        let zmrds = [Zmrd(id: "zmrdicek", value: "hahahhaha"), Zmrd(id: "zmrdicek", value: "hahahhaha") , Zmrd(id: "zmrdicek", value: "hahahhaha") ,Zmrd(id: "zmrdicek", value: "hahahhaha")]
        self.test.zmrdi.addItems(zmrds)
        print("ARRAY: \(self.test.zmrdi.value())")
        try? coreDataStack.managedObjectContext.rx.update(test)
        print("core data: \(Mamrd.fetchAll())")
    }
    @IBAction func createClicked(_ sender: Any) {
        self.test = Mamrd(id: "bacov kokot", value: "kokot")
        try? coreDataStack.managedObjectContext.rx.update(test)
    }

}
//
extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
}
