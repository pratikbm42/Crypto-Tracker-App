//
//  NetworkingManager.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Combine
import Foundation

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse
        case unknow

        var errorDescription: String? {
            switch self {
            case .badURLResponse:
                return "[🔥] Bad response from URL"
            case .unknow:
                return "[⚠️] Unknow error uccured"
            }
        }
    }

    static func download(urlRequest: URLRequest) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchSerialQueue.global(qos: .default))
            .tryMap { try self.handleResponse(output: $0) }
            .receive(on: DispatchSerialQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode < 300
        else { throw NetworkingError.badURLResponse }
        return output.data
    }

    static func handleCompletion(completion: Subscribers.Completion<Error>
    ) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
