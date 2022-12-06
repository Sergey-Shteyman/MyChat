//
//  APIEndpoint.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Moya

enum APIEndpoint {
    case auth(request: AuthRequest)
    case verifyCode(request: VerifyCodeRequest)
    case register(request: RegisterRequest)
    case getUser(request: GetUserRequest)
    case updateUser(request: UpdateUserRequest)
    case refresh(request: RefreshRequest)
    case checkJWT
}

extension APIEndpoint: TargetType {
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        switch self {
        case .checkJWT:
            headers["Authorization"] = "Bearer token"
            // TODO: -
        case let .getUser(request):
            headers["Authorization"] = "Bearer \(request.accessToken)"
        case let .refresh(request):
            headers["Authorization"] = "Bearer \(request.accessToken)"
        case let .updateUser(request):
            headers["Authorization"] = "Bearer \(request.accessToken)"
        case let .register(request):
            headers["Authorization"] = "Bearer \(request.accessToken)"
        case .auth,
             .verifyCode:
            break
        }
        return headers
    }

    var baseURL: URL {
        return URL(string: "https://plannerok.ru")!
    }

    var path: String {
        switch self {
        case .auth:
            return "api/v1/users/send-auth-code/"
        case .verifyCode:
            return "api/v1/users/check-auth-code/"
        case .register:
            return "api/v1/users/register/"
        case .getUser,
             .updateUser:
            return "api/v1/users/me/"
        case .refresh:
            return "api/v1/users/refresh-token/"
        case .checkJWT:
            return "api/v1/users/check-jwt/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .auth,
             .verifyCode,
             .register,
             .refresh:
            return .post
        case .getUser,
             .checkJWT:
            return .get
        case .updateUser:
            return .put
        }
    }

    var task: Moya.Task {
        switch self {
            // TODO: -
        case let .auth(request):
            return requestCompositeParameters(request.body)
        case let .verifyCode(request):
            return requestCompositeParameters(request.body)
        case let .refresh(request):
            return requestCompositeParameters(request.body)
        case let .updateUser(request):
            return requestCompositeParameters(request.body)
        case let .register(request):
            return requestCompositeParameters(request.body)
        default:
            return .requestPlain
        }
    }
}

private extension APIEndpoint {

    func requestCompositeParameters(_ body: Encodable) -> Task {
        var bodyDict: [String: Any] = [:]
        do {
            bodyDict = try body.asDictionary()
        } catch  let error {
            print(error.localizedDescription)
        }
        return .requestCompositeParameters(bodyParameters: bodyDict,
                                           bodyEncoding: JSONEncoding(),
                                           urlParameters: [:])
    }
}

// TODO: - вынести в отдельный файл
import Foundation

extension Encodable {

    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                options: .allowFragments) as? [String: Any] else {
            throw NSError(domain: "Encodable.asDictionary()",
                          code: -1,
                          userInfo: nil)
        }
        return dictionary
    }
}
