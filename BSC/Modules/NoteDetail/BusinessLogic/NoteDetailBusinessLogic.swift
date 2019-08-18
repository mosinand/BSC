//
//  NoteDetailBusinessLogic.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

class NoteDetailBusinessLogic: NSObject, INoteDetailBusinessLogic {
    
    private var note: Note?
    private var currentText: String?
    private let api: NotesApi
    private let router: INoteDetailRouter
    private var timer: Timer?
    
    private let updateNoteQueue = DispatchQueue(label: "com.bsc.am.updateNoteQueue")
    
    init(note: Note?, api: NotesApi, router: INoteDetailRouter) {
        self.note = note
        self.api = api
        self.router = router
        
        super.init()
        resetTimer()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let currentText = self?.currentText else { return }
            self?.updateNoteIfNeeded(text: currentText)
        })
    }
    
    @objc
    private func updateNoteIfNeeded(text: String) {
        
        updateNoteQueue.sync { [weak self] in
            guard let `self` = self else { return }
            
            guard let note = note else {
                self.api.createNote(title: text, completion: { [weak self] note in self?.note = note }, error: { [weak self] e in self?.handle(error: e) })
                return
            }
            
            if note.title != text {
                
                let update = Note(id: note.id, title: text)
                self.note = update
                self.api.update(note: update, completion: { _ in }, error: { [weak self] e in self?.handle(error: e) })
            }
        }
    }
    
    func getNoteText(loading: (() -> Void), completion: @escaping ((String) -> Void)) {
        guard let note = note else { return }
        
        api.getNoteWith(id: note.id,
                        loading: loading,
                        completion: { note in completion(note.title) },
                        error: { _ in })
        
    }
    
    func updateNote(text: String) {
        resetTimer()
        currentText = text
    }
    
    private func handle(error: Error) {
        router.showAlert(title: nil, body: error.localizedDescription)
    }
}
