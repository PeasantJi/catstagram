//
//  MainTabController.swift
//  Catstagram
//
//  Created by JISUNG LEE on 2023/06/01.
//

import UIKit
import Firebase
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewController(withUser: user)
}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }

    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureViewController(withUser user: User) {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage:UIImage(imageLiteralResourceName: "home_unselected"), selectedImage: UIImage(imageLiteralResourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout) )
        
        let search = templateNavigationController(unselectedImage:UIImage(imageLiteralResourceName: "search_unselected"), selectedImage: UIImage(imageLiteralResourceName: "search_selected"), rootViewController: SearchController() )
        
        let imageSelector =  templateNavigationController(unselectedImage:UIImage(imageLiteralResourceName: "plus_unselected"), selectedImage: UIImage(imageLiteralResourceName: "plus_photo"), rootViewController: ImageSelectorController() )
        
        let notifications = templateNavigationController(unselectedImage:UIImage(imageLiteralResourceName: "like_unselected"), selectedImage: UIImage(imageLiteralResourceName: "like_selected"), rootViewController: NotificationController() )
        
        let profileController = ProfileController(user: user)
        let profile = templateNavigationController(unselectedImage:UIImage(imageLiteralResourceName: "profile_unselected"), selectedImage: UIImage(imageLiteralResourceName: "profile_selected"), rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        tabBar.tintColor = .label
        tabBar.isTranslucent = false
        
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage,
                                      rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .label
        
        return nav
    }
}

// MARK: - AuthenticationDelegate
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}
