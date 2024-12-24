import UIKit

final class TaskListViewController: UIViewController {

    var presenter: TaskListViewPresenterProtocol!

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
        view.backgroundColor = .white
        embedViews()
        setupLayout()
        setupTableViewDelegate()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getTasks(with: presenter.selectedDate)
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
        presenter.selectedDate = sender.date
        presenter.getTasks(with: presenter.selectedDate)
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
}

// MARK: - UITableViewDataSource

extension TaskListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForHeader(inSection: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskListTableViewCell.identifier,
            for: indexPath
        ) as? TaskListTableViewCell else { return UITableViewCell() }
        let task = presenter.task(at: indexPath)
        cell.configure(with: task)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TaskListViewProtocol

extension TaskListViewController: TaskListViewProtocol {

    func reloadData() {
        tableView.reloadData()
    }
}
