import XCTest
@testable import PlannerApp

final class AssemblyTests: XCTestCase {

    // MARK: - Private Properties

    private var assembly: AssemblyProtocol?

    // MARK: - Public Method

    override func setUpWithError() throws {
        assembly = Assembly()
    }

    override func tearDownWithError() throws {
        assembly = nil
    }

    func testMakeTaskListModule() throws {
        let router = MockRouter(assembly: assembly)
        let tasksListVC = assembly?.makeTaskListModule(router: router)
        XCTAssertNotNil(tasksListVC)
        XCTAssertTrue(tasksListVC is TaskListViewController)
    }

    func testMakeDetailViewController() throws {
        let mockTask = TaskRealm()
        mockTask.name = "Foo"
        mockTask.dateStart = Date()
        mockTask.dateFinish = Date()
        mockTask.descriptionText = "Foo"

        let router = MockRouter(assembly: assembly)
        let detailVC = assembly?.makeDetailModule(with: mockTask, router: router)
        XCTAssertNotNil(detailVC)
        XCTAssertTrue(detailVC is DetailViewController)
    }

    func testMakeCreateTaskModule() throws {
        let router = MockRouter(assembly: assembly)
        let createTaskVC = assembly?.makeCreateTaskModule(router: router)
        XCTAssertNotNil(createTaskVC)
        XCTAssertTrue(createTaskVC is CreateTaskViewController)
    }
}
