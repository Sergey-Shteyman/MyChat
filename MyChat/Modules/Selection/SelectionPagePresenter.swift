////
////  SelectionPagePresenter.swift
////  MyChat
////
////  Created by Сергей Штейман on 01.12.2022.
////
//
//
//// MARK: - PageSelectionLogic
//protocol PageSelectionLogic: AnyObject {
//    func nextViewController()
//    func previousViewController()
//    func addControllers()
//}
//
//// MARK: - SelectionPagePresenter
//final class SelectionPagePresenter {
//
//    weak var viewController: PageDisplaySelectionLogic?
//    
//    private let moduleBuilder: Buildable
//
//    init(moduleBuilder: Buildable) {
//        self.moduleBuilder = moduleBuilder
//    }
//}
//
//// MARK: - PageSelectionLogic Impl
//extension SelectionPagePresenter: PageSelectionLogic {
//
//    func nextViewController() {
//        let viewController = moduleBuilder.buildMainModule()
//        self.viewController?.routTo(viewController)
//    }
//
//    func previousViewController() {
//        let viewController = moduleBuilder.buildMainModule()
//        self.viewController?.routTo(viewController)
//    }
//
//    func addControllers() {
//
//    }
//}
//
//// MARK: - Private methods
//private extension SelectionPagePresenter {
//
//}
