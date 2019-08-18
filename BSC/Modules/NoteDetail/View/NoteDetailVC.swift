//
//  NoteDetailVC.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import UIKit

class NoteDetailVC: UIViewController, INoteDetailVC {
    
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private let viewModel: INoteDetailViewModel
    
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    init(viewModel: INoteDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NoteDetailVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        viewModel.didLoad()
    }
    
    func set(text: String) {
        textView.text = text
    }
    
    func set(loading: Bool) {
        loading
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
    }
}

extension NoteDetailVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.textDidChange(text: textView.text)
    }
}
