//
//  CreatePartVM.swift
//  garagee
//
//  Created by Jozef Matus on 29/01/2018.
//  Copyright © 2018 Jozef Matus. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxFlow

class CreatePartVM: BaseViewModel, Stepper {

	lazy var cancel: AnyObserver<Void> = AnyObserver(eventHandler: { [unowned self] event in
		if case Event.next = event {
			self.step.accept(GaragerStep.createPartDone)
		}
	})
    
    lazy var save: AnyObserver<String> = AnyObserver(eventHandler: { [unowned self] event in
        if case Event.next = event {
//            event.
//            self.partExist(WithCode: =)
            self.step.accept(GaragerStep.createPartDone)
        }
    })

    override init() {
        super.init()
        self.step.accept(GaragerStep.createPart)
	}
    
    func partExist(WithCode code: String) -> Bool {
        var result = false
        CoreDataService.shared.persistentContainer.performBackgroundTask({ (context) in
            let fr: NSFetchRequest<Part> = Part.fetchRequest()
            fr.predicate = NSPredicate(format: "code = %@", code)
            if let partsResult = try? context.fetch(fr).isEmpty {
                result = partsResult
            }
        })
        return result
    }

}
