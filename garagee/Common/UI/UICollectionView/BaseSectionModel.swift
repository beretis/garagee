//
//  BaseSectionModel.swift
//  BlueBerryExampleProject
//
//  Created by Jozef Matus on 13/09/2017.
//  Copyright © 2017 Blueberry. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol HeaderSectionModelType: SectionModelType {
    func titleForSections() -> String
}

protocol FooterSectionModelType: SectionModelType {

}

protocol HeaderFooterSectionModelType: HeaderSectionModelType, FooterSectionModelType {

}

struct BaseSectionModel: SectionModelType {

    typealias Item = CellVM

    let items: [CellVM]

    init(items: [CellVM], plusAction: (() -> Void)? = nil) {
        self.items = items
    }

    init(original: BaseSectionModel, items: [CellVM]) {
        self = BaseSectionModel(items: original.items)
    }

}
