//
//  INotesListBusinessLogic.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INotesListBusinessLogic {
    func getNotes(loading: (() -> Void), completion: @escaping (([Note]) -> Void), error: @escaping ((Error) -> Void))
    func remove(note: Note, loading: (() -> Void), completion: @escaping (() -> Void), error: @escaping ((Error) -> Void))
    func showNoteDetail(note: Note)
    func createNewNote()
}
