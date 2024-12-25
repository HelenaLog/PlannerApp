import Foundation

extension NetworkService: NetworkServiceProtocol {
    func fetchTasks(completion: @escaping (Result<[Task], NetworkError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Tasks", withExtension: "json") else { return }
        self.fetch([Task].self, for: url, completion: completion)
    }
}
