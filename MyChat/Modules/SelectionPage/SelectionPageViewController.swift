//
//  SelectionPageViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 01.12.2022.
//

import UIKit


// MARK: - PageDisplayLogic
protocol PageDisplaySelectionLogic: AnyObject {
    
}

// MARK: - SelectionPageViewController
final class SelectionPageViewController: UIPageViewController {
    
    private lazy var arrayViewControllers = [UIViewController]()
    
    var presenter: PageSelectionLogic?
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .black
        addControllersToArray()
        self.setViewControllers([arrayViewControllers[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addControllersToArray() {
        arrayViewControllers.append(RegistrationViewController())
    }
}

// MARK: - PageDisplaySelectionLogic Impl
extension SelectionPageViewController: PageDisplaySelectionLogic {
    
}

// MARK: - UIPageViewControllerDelegate
extension SelectionPageViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}

// MARK: - UIPageViewControllerDataSource
extension SelectionPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return RegistrationViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return RegistrationViewController()
    }
    
    
}
