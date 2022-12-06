//
//  ProfilePresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

protocol ProfilePresentationLogic: AnyObject {
    func viewDidLoad()
    func didChangeValue()
}

final class ProfilePresenter {
    weak var viewController: ProfileDisplayLogic?

    private var apiService: APIServiceable
    private var databaseService: DatabaseServicable
    private var keychainService: Storagable

    private var viewModel: ProfileViewModel?

    init(
        apiService: APIServiceable,
        databaseService: DatabaseServicable,
        keychainService: Storagable
    ) {
        self.apiService = apiService
        self.databaseService = databaseService
        self.keychainService = keychainService
    }
}

extension ProfilePresenter: ProfilePresentationLogic {
    func viewDidLoad() {
        Task(priority: .utility) {
            do {
                // MARK: - это мы пытаемся получить пользователя с бека (это должно быть сделано после получения токенов)
//                let accessToken = try keychainService.fetch(for: .accessToken)
//                let request = GetUserRequest(accessToken: accessToken)
//                let userResponse = try await apiService.getUser(request: request)

                // MARK: - это мы пытаемся получить пользователя из БД

                guard let userDBModel = try databaseService.read(UserDBModel.self).first else {
                    // handle error
                    return
                }
                let viewModel = ProfileViewModel(dbModel: userDBModel)
                self.viewModel = viewModel

                await MainActor.run {
                    viewController?.updateView(viewModel)
                }
            } catch {
                await MainActor.run {
                    viewController?.showError()
                }
            }
        }
    }

    // придут параметры и их нужно будет положить в request и обновить viewModel/model
    func didChangeValue() {
        let image = UIImage(named: "qwerty")!
        let imageBase64 = image.pngData()?.base64EncodedString() ?? ""
        Task(priority: .utility) {
            do {
                let accessToken = try keychainService.fetch(for: .accessToken)

                let body = UpdateUserBody(
                    name: "Test555",
                    username: "ios_backender",
                    birthday: "2022-11-29",
                    city: "",
                    vk: "",
                    instagram: "",
                    status: "",
                    avatar: .init(
                        filename: "qwerty.png",
                        base64: imageBase64
                    )
                )
                let request = UpdateUserRequest(accessToken: accessToken, body: body)
                let userResponse = try await apiService.updateUser(request: request)

                print(userResponse)

                // response map to viewModel, and save to DB
                let newViewModel = ProfileViewModel(dbModel: .init(name: "", username: "", birthday: "", city: "", vk: "", instagram: "", status: "", avatar: nil))
                guard var new = self.viewModel else {
                    return
                }
                new.name = "1232"

                let userDBModel = UserDBModel(viewModel: newViewModel)
                try databaseService.create(userDBModel)

                await MainActor.run {
                    viewController?.updateView(newViewModel)
                }
            } catch {
                print(error, error.localizedDescription)
                await MainActor.run {
                    viewController?.showError()
                }
            }
        }
    }
}
