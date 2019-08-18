//
//  NotesListRouter.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
import UIKit

class NotesListRouter: BaseRouter, INotesListRouter {
    
    func showNoteDetail(note: Note) {
        let vc = assembleDetailModule(with: note)
        push(viewController: vc, animated: true)
    }
    
    func showNewNote() {
        let vc = assembleDetailModule(with: nil)
        push(viewController: vc, animated: true)
    }
    
    private func assembleDetailModule(with note: Note?) -> UIViewController {
        let api = NotesApi()
        let router = NoteDetailRouter(navigationController: self.navigationController)
        let bl = NoteDetailBusinessLogic(note: note, api: api, router: router)
        let vm = NoteDetailViewModel(businessLogic: bl)
        let vc = NoteDetailVC(viewModel: vm)
        vm.view = vc
        
        return vc
    }
}
