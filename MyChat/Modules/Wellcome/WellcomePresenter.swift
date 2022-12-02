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
    
    weak var viewController: WellcomDisplayLogic?
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - WellcomPresentationLogic Impl
extension WellcomePresenter: WellcomPresentationLogic {
    
    func didTapButton() {
        let viewController = moduleBuilder.buildAuthPageModule()
        self.viewController?.routTo(viewController)
    }
}
