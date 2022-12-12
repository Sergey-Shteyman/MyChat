//
//  WellcomePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//


// MARK: - WellcomPresentationLogic
protocol WellcomPresentationLogic: AnyObject {
    func didTapButton()
}

// MARK: - WellcomePresenter
final class WellcomePresenter {
    
    private let moduleBuilder: Buildable
    private let router: Router
    
    weak var viewController: WellcomDisplayLogic?
    
    init(
        moduleBuilder: Buildable,
        router: Router
    ) {
        self.moduleBuilder = moduleBuilder
        self.router = router
    }
}

// MARK: - WellcomPresentationLogic Impl
extension WellcomePresenter: WellcomPresentationLogic {
    
    func didTapButton() {
        let viewController = moduleBuilder.buildAuthPageModule()
        router.push(viewController, true)
    }
}
