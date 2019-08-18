//
//  NotesListRouterMock.swift
//  BSCTests
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
@testable import BSC

class NotesListRouterMock: BaseRouterMock, INotesListRouter {
    
    var showNoteDetailCalled = false
    var showNewNoteCalled = false
    
    func showNoteDetail(note: Note) {
        showNoteDetailCalled = true
    }
    
    func showNewNote() {
        showNewNoteCalled = true
    }
}
