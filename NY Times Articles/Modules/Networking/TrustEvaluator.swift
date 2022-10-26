//
//  TrustEvaluator.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import Alamofire
import Foundation

public protocol TrustEvaluatorType {
    var evaluator: ServerTrustEvaluating? { get }
}

enum TrustEvaluator: TrustEvaluatorType {
    case publicKey(key: String)
    case certificate(path: String)
    
    var evaluator: ServerTrustEvaluating? {
        switch self {
        case .certificate(let path):
            return makePinnedCertificateEvaluator(path)
        case .publicKey(let key):
            return makePublicKeyEvaluator(key)
        }
    }
    
    private func makePublicKeyEvaluator(_ publicKey: String) -> PublicKeysTrustEvaluator? {
        guard let certificateData = Data(base64Encoded: publicKey, options: []), let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) else { return nil }

        var trust: SecTrust?
        let policy = SecPolicyCreateBasicX509()
        let status = SecTrustCreateWithCertificates(certificate, policy, &trust)

        guard status == errSecSuccess, let secTrust = trust, let publicSecKey = SecTrustCopyPublicKey(secTrust) else {
            return nil
        }
        return PublicKeysTrustEvaluator(keys: [publicSecKey], performDefaultValidation: true, validateHost: true)
    }

    private func makePinnedCertificateEvaluator(_ certificatePath: String) -> PinnedCertificatesTrustEvaluator? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: certificatePath))
        guard let data = data, let certificate = SecCertificateCreateWithData(nil, data as CFData)  else {
            return nil
        }
        return PinnedCertificatesTrustEvaluator(certificates: [certificate])
    }
}

