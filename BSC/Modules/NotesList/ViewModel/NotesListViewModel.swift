//
//  NotesListViewModel.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

class NotesListViewModel: INotesListViewModel {
    
    private let businessLogic: INotesListBusinessLogic
    weak var view: INotesListViewController?
    
    private var loadedNotes = [Note]() {
        didSet {
            view?.show(notes: loadedNotes)
        }
    }
    
    init(businessLogic: INotesListBusinessLogic) {
        self.businessLogic = businessLogic
    }
    
    func createNote() {
        businessLogic.createNewNote()
    }
    
    func selectNoteWith(id: Int) {
        guard let note = getNoteWith(id: id) else { return }
        
        businessLogic.showNoteDetail(note: note)
    }
    
    func remove(note: Note) {
        loadedNotes = loadedNotes.filter { $0 != note }
        
        if loadedNotes.isEmpty {
            view?.endEditing()
        }
        
        businessLogic.remove(note: note,
                             loading: { [weak self] in self?.view?.set(loading: true) },
                             completion: { [weak self] in self?.view?.set(loading: false) },
                             error: { _ in })
    }
    
    func willAppear() {
        loadNotes()
    }
    
    private func getNoteWith(id: Int) -> Note? {
        return loadedNotes.filter { $0.id == id }.first
    }
    
    private func loadNotes() {
        businessLogic
            .getNotes(loading: { [weak self] in
                self?.view?.set(loading: true)
                }, completion: {  [weak self] notes in
                    self?.loadedNotes = notes
                    DispatchQueue.main.async {
                        self?.view?.set(loading: false)
                        self?.view?.show(notes: notes)
                    }
            }) { [weak self] e in
                self?.view?.set(loading: false)
                print(e)
        }
    }
}
