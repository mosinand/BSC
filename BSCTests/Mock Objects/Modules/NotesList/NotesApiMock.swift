//
//  NotesApiMock.swift
//  BSCTests
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
@testable import BSC

class NotesApiMock: INotesApi {
    
    var getNotesCalled = false
    var removeNoteCalled = false
    
    func getNotes(loading: (() -> Void), completion: @escaping (([Note]) -> Void), error: @escaping ((Error) -> Void)) {
        getNotesCalled = true
    }
    
    func removeNoteWith(id: Int, loading: (() -> Void), completion: @escaping (() -> Void), error: @escaping ((Error) -> Void)) {
        removeNoteCalled = true
    }
    
    func getNoteWith(id: Int, loading: (() -> Void), completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void)) {
        
    }
    
    func createNote(title: String, completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void)) {
        completion(Note.mock)
    }
}
