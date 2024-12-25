import Foundation

protocol NetworkServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], NetworkError>) -> Void)
}
