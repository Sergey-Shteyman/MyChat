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
    func viewWillDisappear()
}

final class EditProfilePresenter {
    
    weak var viewController: EditProfileDisplayLogic?
    weak var delegate: EditProfilePresenterDelegate?

    private let apiService: APIServiceable
    private let keychainService: Storagable
    private let databaseService: DatabaseServicable
    private let codeNumberPhone: String
    private let numberPhone: String

    private var userModel: UserModel

    init(
        databaseService: DatabaseServicable,
        userModel: UserModel,
        codeNumberPhone: String,
        numberPhone: String,
        apiService: APIServiceable,
        keychainService: Storagable
    ) {
        self.databaseService = databaseService
        self.userModel = userModel
        self.codeNumberPhone = codeNumberPhone
        self.numberPhone = numberPhone
        self.apiService = apiService
        self.keychainService = keychainService
    }
}

extension EditProfilePresenter: EditProfilePresentationLogic {
    
    func viewWillDisappear() {
        viewController?.showLoading()
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
                    viewController?.popToPreviousPage()
                }
            } catch {
                await MainActor.run {
                    viewController?.hideLoading()
                    viewController?.showError()
                }
            }
        }
    }
    
    func viewDidLoad() {
        let viewModel = ProfileViewModel(userModel: userModel)
        viewController?.updateView(viewModel)
    }
}
