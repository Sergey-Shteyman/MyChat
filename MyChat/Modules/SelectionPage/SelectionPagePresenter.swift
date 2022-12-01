//
//  SelectionPagePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 01.12.2022.
//


// MARK: - PageSelectionLogic
protocol PageSelectionLogic: AnyObject {
    
}

// MARK: - SelectionPagePresenter
final class SelectionPagePresenter {
    
    weak var viewController: PageDisplaySelectionLogic?
}

// MARK: - PageSelectionLogic Impl
extension SelectionPagePresenter: PageSelectionLogic {
    
}

// MARK: - Private methods
private extension SelectionPagePresenter {
    
}
