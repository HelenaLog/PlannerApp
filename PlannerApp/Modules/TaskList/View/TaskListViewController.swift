import UIKit

final class TaskListViewController: UIViewController {

    private let mockTasks: [MockTask] = [
        MockTask(
            id: 1,
            name: "My task",
            dateStart: 147600000,
            dateFinish: 147610000,
            description: "Description of my task"
        ),
        MockTask(
            id: 2,
            name: "New task",
            dateStart: 147600000,
            dateFinish: 147610000,
            description: "Description of new task"
        )
    ]

    private var sections = [Section]()
    private var selectedDate = Date()

    // MARK: - Private Visual Components

    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: TaskListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        embedViews()
        setupLayout()
        setupTableViewDelegate()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTasks(with: selectedDate)
    }

    // MARK: - Embed views

    private func embedViews() {
        view.addSubview(datePicker)
        view.addSubview(tableView)
    }

    // MARK: - Setup Delegate

    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Setup Behaviour

    private func setupBehaviour() {
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add Task",
            style: .done,
            target: self,
            action: #selector(addTaskTapped)
        )
    }

    // MARK: - Action

    @objc
    func dateChanged(sender: UIDatePicker) {
        selectedDate = sender.date
        self.getTasks(with: selectedDate)
    }

    @objc
    func addTaskTapped() {
        print("addTaskTapped")
    }

    // MARK: - Setup Layout

    private func setupLayout() {

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func getTasks(with selectedDate: Date) {
        sections = TaskSectionCreator.createSections(from: mockTasks)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].time
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskListTableViewCell.identifier,
            for: indexPath
        ) as? TaskListTableViewCell else { return UITableViewCell() }
        let task = sections[indexPath.section].tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Show DetailVC")
    }
}
