//
//  EditProfilePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//


protocol EditProfilePresenterDelegate: AnyObject {
    func didSaveUser(userModel: UserModel)
}


protocol EditProfilePresentationLogic: AnyObject {
    func viewDidLoad()
    func viewWillDisappear(status: String?, city: String?, birthday: String?)
    func changeAvatar()
}

final class EditProfilePresenter {
    
    weak var viewController: EditProfileDisplayLogic?
    weak var delegate: EditProfilePresenterDelegate?

    private let apiService: APIServiceable
    private let keychainService: Storagable
    private let databaseService: DatabaseServicable
    private let codeNumberPhone: String
    private let numberPhone: String
    private let router: Router

    private var userModel: UserModel

    init(
        router: Router,
        databaseService: DatabaseServicable,
        userModel: UserModel,
        codeNumberPhone: String,
        numberPhone: String,
        apiService: APIServiceable,
        keychainService: Storagable
    ) {
        self.router = router
        self.databaseService = databaseService
        self.userModel = userModel
        self.codeNumberPhone = codeNumberPhone
        self.numberPhone = numberPhone
        self.apiService = apiService
        self.keychainService = keychainService
    }
}

extension EditProfilePresenter: EditProfilePresentationLogic {
    
    func changeAvatar() {
        viewController?.presentPhotoActionSheet()
    }
    
    func viewWillDisappear(status: String?, city: String?, birthday: String?) {
        viewController?.showLoading()
        userModel.status = status
        userModel.city = city
        userModel.birthday = Formatter.formatString(birthday, format: .ddMMyyyy)
        Task {
            do {
                let accessToken = try keychainService.fetch(for: .accessToken)
                let body = UpdateUserBody(userModel: userModel)
                let request = UpdateUserRequest(accessToken: accessToken, body: body)
                let response = try await apiService.updateUser(request: request)
                
                let userDMModel = UserDBModel(userModel: userModel)
                // TODO: - посмотреть как то удалять попроще
                try databaseService.deleteAll()
                try databaseService.create(userDMModel)
                
                await MainActor.run {
                    viewController?.hideLoading()
                    delegate?.didSaveUser(userModel: userModel)
                    router.popViewController(true)
                }
            } catch {
                await MainActor.run {
                    viewController?.hideLoading()
                    viewController?.showEditProfileError()
                }
            }
        }
    }
    
    func viewDidLoad() {
        let viewModel = ProfileViewModel(userModel: userModel)
        viewController?.updateView(viewModel)
    }
}
