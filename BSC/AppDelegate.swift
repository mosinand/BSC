//
//  AppDelegate.swift
//  BSC
//
//  Created by Andrey Mosin on 14/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let nvc = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        nvc.pushViewController(getStartingModule(navigation: nvc), animated: false)
        
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func getStartingModule(navigation: UINavigationController) -> UIViewController {
        let api = NotesApi()
        let router = NotesListRouter(navigationController: navigation)
        let bl = NotesListBusinessLogic(api: api, router: router)
        let vm = NotesListViewModel(businessLogic: bl)
        let vc = NotesListVC(viewModel: vm)
        vm.view = vc
        
        return vc
    }
}

