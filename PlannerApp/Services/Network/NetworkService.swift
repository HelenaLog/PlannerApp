import Foundation

final class NetworkService {

    func fetch<T: Decodable>(_ type: T.Type, for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data, error == nil else {
                return completion(.failure(.badData))
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970

            do {
                let dataModel = try decoder.decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.badDecode))
            }
        }.resume()
    }
}
