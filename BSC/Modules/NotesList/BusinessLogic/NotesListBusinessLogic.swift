//
//  NotesListBusinessLogic.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

class NotesListBusinessLogic: INotesListBusinessLogic {
    
    private let api: INotesApi
    private let router: INotesListRouter
    
    init(api: INotesApi, router: INotesListRouter) {
        self.api = api
        self.router = router
    }
    
    func getNotes(loading: (() -> Void), completion: @escaping (([Note]) -> Void), error: @escaping ((Error) -> Void)) {
        api.getNotes(loading: loading, completion: completion, error: error)
    }
    
    func remove(note: Note, loading: (() -> Void), completion: @escaping (() -> Void), error: @escaping ((Error) -> Void)) {
        api.removeNoteWith(id: note.id, loading: loading, completion: completion, error: error)
    }
    
    func showNoteDetail(note: Note) {
        router.showNoteDetail(note: note)
    }
    
    func createNewNote() {
        router.showNewNote()
    }
}
