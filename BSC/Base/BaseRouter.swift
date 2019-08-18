//
//  BaseRouter.swift
//  BSC
//
//  Created by Andrey Mosin on 18/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation
import UIKit

class BaseRouter {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func showAlert(title: String?, body: String?) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        navigationController.present(alert, animated: true, completion: nil)
    }
}
