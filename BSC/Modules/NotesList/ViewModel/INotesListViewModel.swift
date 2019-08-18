//
//  INotesListViewModel.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INotesListViewModel: BaseViewModel {
    func remove(note: Note)
    func selectNoteWith(id: Int)
    func createNote()
    func willAppear()
}
