//
//  EditProfilePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import Foundation
import UIKit


// MARK: - EditProfilePresenterDelegate
protocol EditProfilePresenterDelegate: AnyObject {
    func didSaveUser(userModel: UserModel)
    func didUpdateAvatar(image: UIImage)
}


// MARK: - EditProfilePresentationLogic
protocol EditProfilePresentationLogic: AnyObject {
    func viewDidLoad()
    func viewWillDisappear(status: String?, city: String?, birthday: String?)
    func changeAvatar()
    func setDate(_ date: Date)
    func didUpdateAvatar(_ image: UIImage)
}

// MARK: - EditProfilePresenter
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
    private var imageBase64: String?

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

// MARK: - EditProfilePresentationLogic Impl
extension EditProfilePresenter: EditProfilePresentationLogic {
    
    func didUpdateAvatar(_ image: UIImage) {
        imageBase64 = image.jpegData(compressionQuality: 1)?.base64EncodedString()
        viewController?.updateAvatar(image)
        delegate?.didUpdateAvatar(image: image)
    }
    
    func setDate(_ date: Date) {
        let stringDate = FormatterDate.formatDate(date, format: .ddMMyyyy)
        guard let stringDate = stringDate else {
            return
        }
        setHoroscope(from: stringDate)
        viewController?.displayDate(stringDate)
    }
    
    func changeAvatar() {
        viewController?.presentPhotoActionSheet()
    }
    
    func viewWillDisappear(status: String?, city: String?, birthday: String?) {
        let date = FormatterDate.formatString(birthday, format: .ddMMyyyy)
        viewController?.showLoading()
        userModel.status = status
        userModel.city = city
        userModel.birthday = date
        userModel.horoscope = HoroscopeWorker.fetchHoroscope(from: date)
        userModel.avatar = imageBase64
        Task {
            do {
                let accessToken = try keychainService.fetch(for: .accessToken)
                let userAvatar = UpdateUserAvatar(base64: imageBase64)
                let body = UpdateUserBody(userModel: userModel, avatar: userAvatar)
                let request = UpdateUserRequest(accessToken: accessToken, body: body)
                let response = try await apiService.updateUser(request: request)
                
                userModel.avatar = response.avatars?.avatar
                
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

// MARK: - Private methods
private extension EditProfilePresenter {
    
    func setHoroscope(from birthday: String?) {
        let date = FormatterDate.formatString(birthday, format: .ddMMyyyy)
        let horoscope = HoroscopeWorker.fetchHoroscope(from: date)
        viewController?.configuredHoroscopeLabel(horoscope.rawValue)
    }
}
