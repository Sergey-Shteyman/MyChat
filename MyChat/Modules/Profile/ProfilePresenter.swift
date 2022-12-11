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

    private let router: Router
    private let databaseService: DatabaseServicable
    private let codeNumberPhone: String
    private let numberPhone: String
    private let moduleBuilder: Buildable
    private let apiService: APIServiceable
    private let keyChainService: Storagable

    init(
        router: Router,
        codeNumberPhone: String,
        numberPhone: String,
        databaseService: DatabaseServicable,
        moduleBuilder: Buildable,
        apiService: APIServiceable,
        keyChainService: Storagable
    ) {
        self.router = router
        self.codeNumberPhone = codeNumberPhone
        self.numberPhone = numberPhone
        self.databaseService = databaseService
        self.moduleBuilder = moduleBuilder
        self.apiService = apiService
        self.keyChainService = keyChainService
    }
}

extension ProfilePresenter: ProfilePresentationLogic {

    func viewDidLoad() {
        viewController?.showLoading()
        Task(priority: .utility) {
            do {
                guard let userDBModel = try databaseService.read(UserDBModel.self).first else {
                    fetchUser()
                    return
                }
                let userModel = UserModel(userDBModel: userDBModel)
                let viewModel = ProfileViewModel(userModel: userModel)
                self.userModel = userModel

                await MainActor.run {
                    viewController?.hideLoading()
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
        router.push(editProfileModule, true)
    }
}

private extension ProfilePresenter {
    
    func fetchUser() {
        Task {
            do {
                let accessToken = try keyChainService.fetch(for: .accessToken)
                let request = GetUserRequest(accessToken: accessToken)
                let response = try await apiService.getUser(request: request)
                let userModel = UserModel(profileData: response.profileData)
                let viewModel = ProfileViewModel(userModel: userModel)
                
                let object = UserDBModel(userModel: userModel)
                try databaseService.create(object)
                
                self.userModel = userModel
                await MainActor.run {
                    viewController?.hideLoading()
                    viewController?.updateView(viewModel)
                }
            } catch {
                await showError()
            }
        }
    }
    
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
