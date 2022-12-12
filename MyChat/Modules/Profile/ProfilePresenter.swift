//
//  ProfilePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import class UIKit.UIImage

// MARK: - ProfilePresentationLogic
protocol ProfilePresentationLogic: AnyObject {
    func viewDidLoad()
    func didTapEditButton()
    func viewWillAppear()
}

// MARK: - ProfilePresenter
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
    private let imageCashService: ImageCacheServicable

    init(
        router: Router,
        codeNumberPhone: String,
        numberPhone: String,
        databaseService: DatabaseServicable,
        moduleBuilder: Buildable,
        apiService: APIServiceable,
        keyChainService: Storagable,
        imageCashService: ImageCacheServicable
    ) {
        self.router = router
        self.codeNumberPhone = codeNumberPhone
        self.numberPhone = numberPhone
        self.databaseService = databaseService
        self.moduleBuilder = moduleBuilder
        self.apiService = apiService
        self.keyChainService = keyChainService
        self.imageCashService = imageCashService
    }
}

// MARK: - ProfilePresentationLogic impl
extension ProfilePresenter: ProfilePresentationLogic {
    
    func viewWillAppear() {
        viewController?.showLoading()
    }

    func viewDidLoad() {
        Task(priority: .utility) {
            do {
                guard let userDBModel = try databaseService.read(UserDBModel.self).first else {
                    fetchUser()
                    return
                }
                let userModel = UserModel(userDBModel: userDBModel)
                let viewModel = ProfileViewModel(userModel: userModel)
                let image = imageCashService.fetchImage(with: .userAvatarFileName)
                self.userModel = userModel

                await MainActor.run {
                    viewController?.hideLoading()
                    viewController?.updateView(viewModel)
                    viewController?.updateAvatar(image: image)
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

// MARK: - EditProfilePresenterDelegate impl
extension ProfilePresenter: EditProfilePresenterDelegate {
    func didSaveUser(userModel: UserModel) {
        self.userModel = userModel
        let viewModel = ProfileViewModel(userModel: userModel)
        self.viewController?.updateView(viewModel)
        viewController?.hideLoading()
    }
    
    func didUpdateAvatar(image: UIImage?) {
        viewController?.updateAvatar(image: image)
        viewController?.hideLoading()
    }
}

// MARK: - ProfilePresenter private methods
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
