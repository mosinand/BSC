//
//  NotesApi.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

protocol INotesApi {
    func getNotes(loading: (() -> Void), completion: @escaping (([Note]) -> Void), error: @escaping ((Error) -> Void))
    func removeNoteWith(id: Int, loading: (() -> Void), completion: @escaping (() -> Void), error: @escaping ((Error) -> Void))
    func getNoteWith(id: Int, loading: (() -> Void), completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void))
    func createNote(title: String, completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void))
}

class NotesApi: INotesApi {
    
    func removeNoteWith(id: Int, loading: (() -> Void), completion: @escaping (() -> Void), error: @escaping ((Error) -> Void)) {
        let url = String(format: ApiEndPoint.note.rawValue, "\(id)")
        ApiProvider.request(method: .delete, endPoint: url, loadingHandler: loading) { (result: Result<Void, Error>) in
            switch result {
            case .failure(let e):
                error(e)
            case .success:
                completion()
            }
        }
    }
    
    func getNotes(loading: (() -> Void), completion: @escaping (([Note]) -> Void), error: @escaping ((Error) -> Void)) {
        ApiProvider.request(method: .get, endPoint: .notes, loadingHandler: loading) { [weak self] (result: Result<[Note], Error>) in
            self?.handleResult(result: result, completion: completion, error: error)
        }
    }
    
    func getNoteWith(id: Int, loading: (() -> Void), completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void)) {
        let url = String(format: ApiEndPoint.note.rawValue, "\(id)")
        ApiProvider.request(method: .get, endPoint: url, loadingHandler: loading)  { [weak self] (result: Result<Note, Error>) in
            self?.handleResult(result: result, completion: completion, error: error)
        }
    }
    
    func createNote(title: String, completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void)) {
        let parameters = ["title": title]
        
        ApiProvider.request(method: .post, endPoint: .notes, parameters: parameters, loadingHandler: {}) { [weak self] (result: Result<Note, Error>) in
            self?.handleResult(result: result, completion: completion, error: error)
        }
    }
    
    func update(note: Note, completion: @escaping ((Note) -> Void), error: @escaping ((Error) -> Void)) {
        let url = String(format: ApiEndPoint.note.rawValue, "\(note.id)")
        let parameters = ["title": note.title]
        
        ApiProvider.request(method: .put, endPoint: url, parameters: parameters, loadingHandler: {}, resultHandler: { result in self.handleResult(result: result, completion: completion, error: error) })
    }
    
    private func handleResult<T: Decodable>(result: Result<T, Error>, completion: @escaping ((T) -> Void), error: @escaping ((Error) -> Void)) {
        switch result {
        case .success(let some):
            completion(some)
        case .failure(let e):
            error(e)
        }
    }
}
