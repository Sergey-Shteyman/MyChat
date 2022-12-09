//
//  ProfilePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

protocol ProfilePresentationLogic: AnyObject {
    func viewDidLoad()
    func didTapEditButton()
}

final class ProfilePresenter {
    weak var viewController: ProfileDisplayLogic?
    
    private var userModel: UserModel?

    private let databaseService: DatabaseServicable
    private let codeNumberPhone: String
    private let numberPhone: String
    private let moduleBuilder: Buildable

    init(
        codeNumberPhone: String,
        numberPhone: String,
        databaseService: DatabaseServicable,
        moduleBuilder: Buildable
    ) {
        self.codeNumberPhone = codeNumberPhone
        self.numberPhone = numberPhone
        self.databaseService = databaseService
        self.moduleBuilder = moduleBuilder
    }
}

extension ProfilePresenter: ProfilePresentationLogic {
    func viewDidLoad() {
        viewController?.showLoading()
        Task(priority: .utility) {
            do {
                guard let userDBModel = try databaseService.read(UserDBModel.self).first else {
                    await showError()
                    return
                }
                let userModel = UserModel(userDBModel: userDBModel)
                let viewModel = ProfileViewModel(userModel: userModel)
                self.userModel = userModel

                await MainActor.run {
                    viewController?.updateView(viewModel)
                }
            } catch {
                await showError()
            }
        }
    }
    
    func didTapEditButton() {
        guard let userModel = userModel else {
            viewController?.showProfileError()
            return
        }
        let editProfileModule = moduleBuilder.buildEditProfileModule(
            userModel, self,
            codeNumberPhone, numberPhone
        )
        viewController?.routTo(editProfileModule)
    }
}

private extension ProfilePresenter {
    
    func showError() async {
        await MainActor.run {
            viewController?.hideLoading()
            viewController?.showProfileError()
        }
    }
}

extension ProfilePresenter: EditProfilePresenterDelegate {
    
    func didSaveUser(userModel: UserModel) {
        self.userModel = userModel
        let viewModel = ProfileViewModel(userModel: userModel)
        self.viewController?.updateView(viewModel)
    }
}
