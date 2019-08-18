//
//  NoteDetailViewModel.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

class NoteDetailViewModel: INoteDetailViewModel {
    
    private let businessLogic: INoteDetailBusinessLogic
    weak var view: INoteDetailVC?
    
    init(businessLogic: INoteDetailBusinessLogic) {
        self.businessLogic = businessLogic
    }
    
    func didLoad() {
        getInitialText()
    }
    
    func textDidChange(text: String) {
        businessLogic.updateNote(text: text)
    }
    
    private func getInitialText() {
        businessLogic.getNoteText(loading: { [weak self] in self?.view?.set(loading: true) },
                                  completion: { [weak self] text in
                                    DispatchQueue.main.async {
                                        self?.view?.set(loading: false)
                                        self?.view?.set(text: text)
                                    }
        })
    }
}
