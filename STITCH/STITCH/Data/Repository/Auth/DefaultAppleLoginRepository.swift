//
//  DefaultAppleLoginRepository.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import Foundation

import RxSwift
import SwiftJWT

struct Payload: Claims {
    var iss = "SLD3XB8ML6"
    var iat = Int(Date().timeIntervalSince1970)
    var exp = Int(Date().timeIntervalSince1970) + 3600
    var aud = "https://appleid.apple.com"
    var sub = Bundle.main.bundleIdentifier!
}

final class DefaultAppleLoginRepository: AppleLoginRepository {
    
    // MARK: - Properties
    
    private let appleIDService: URLSessionNetworkService
    
    // MARK: - Initializer
    
    init(appleIDService: URLSessionNetworkService) {
        self.appleIDService = appleIDService
    }
    
    // MARK: - Methods
    
    private func clientSecret() -> String? {
        guard let privateAuthKey = APIKey.privateAuthKey.data(using: .utf8) else { return nil }
        var jwt = JWT(claims: Payload())
        let jwtSigner = JWTSigner.es256(privateKey: privateAuthKey)
        guard let signedJWT = try? jwt.sign(using: jwtSigner) else { return nil }
        return signedJWT
    }
    
    func refreshToken(authorizationCode: String) -> Observable<String> {
        guard let clientSecret = clientSecret() else { return .error(SocialLoginError.clientSecret) }
        let endpoint = AuthAPIEndpoints.refreshToken(
            authorizationCode: authorizationCode,
            clientSecret: clientSecret
        )
       
        return appleIDService.request(with: endpoint)
            .map(RefreshTokenResponseDTO.self)
            .compactMap { $0.refresh_token }
    }
    
    func revokeToken(refreshToken: String) -> Observable<Void> {
        guard let clientSecret = clientSecret() else { return .error(SocialLoginError.clientSecret) }
        let endpoint = AuthAPIEndpoints.revokeToken(
            refreshToken: refreshToken,
            clientSecret: clientSecret
        )
        return appleIDService.request(with: endpoint).map { _ in () }
    }
}
