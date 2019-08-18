//
//  NotesListBusinessLogicTests.swift
//  BSCTests
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import XCTest

@testable import BSC

class NotesListBusinessLogicTests: XCTestCase {

    func testNotesLoaded() {
        
        let apiMock = NotesApiMock()
        let logic = NotesListBusinessLogic(api: apiMock, router: NotesListRouterMock())
        
        logic.getNotes(loading: {}, completion: { _ in }, error: { _ in })
        XCTAssert(apiMock.getNotesCalled)
    }
    
    func testRemoveNote() {
        
        let apiMock = NotesApiMock()
        let logic = NotesListBusinessLogic(api: apiMock, router: NotesListRouterMock())
        
        logic.remove(note: Note.mock, loading: {}, completion: {}, error: { _ in })
        XCTAssert(apiMock.removeNoteCalled)
    }

    func testNoteDetailOpened() {
        let routerMock = NotesListRouterMock()
        let logic = NotesListBusinessLogic(api: NotesApiMock(), router: routerMock)
        
        logic.showNoteDetail(note: Note.mock)
        XCTAssert(routerMock.showNoteDetailCalled)
    }
    
    func testNewNoteOpened() {
        let routerMock = NotesListRouterMock()
        let logic = NotesListBusinessLogic(api: NotesApiMock(), router: routerMock)
        
        logic.createNewNote()
        XCTAssert(routerMock.showNewNoteCalled)
    }
}
