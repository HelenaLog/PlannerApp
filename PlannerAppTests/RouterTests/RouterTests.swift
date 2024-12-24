import XCTest
@testable import PlannerApp

final class RouterTests: XCTestCase {

    // MARK: - Private Properties

    private var router: RouterProtocol?
    private var navigationController = MockNavigationController()
    private let assembly = Assembly()

    // MARK: - Public Method

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assembly: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testShowCreateTaskVC() throws {
        router?.goToCreateTask()
        let createTaskVC = navigationController.presentedVC
        XCTAssertTrue(createTaskVC is CreateTaskViewController)
    }

    func testShowDetailVC() throws {
        let mockTask = Task()
        mockTask.dateStart = Date()
        mockTask.dateFinish = Date()
        mockTask.name = "Foo"
        mockTask.taskDescription = "Foo"

        router?.goToDetail(task: mockTask)
        let detailVC = navigationController.presentedVC
        XCTAssertTrue(detailVC is DetailViewController)
    }
}
