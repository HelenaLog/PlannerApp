import UIKit

final class DetailViewController: UIViewController {

    private var mockTask: MockTask

    // MARK: - Private Visual Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        embedViews()
        setupLayout()
        setupNavigationBar()
        configure(with: mockTask)
    }

    // MARK: - Init

    init(mockTask: MockTask) {
        self.mockTask = mockTask
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Embed views

    private func embedViews() {
        view.addSubview(scrollView)
        [
            titleLabel,
            dayLabel,
            timeLabel,
            descriptionLabel
        ].forEach { scrollView.addSubview($0) }
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Delete",
            style: .done,
            target: self,
            action: #selector(deleteTaskTapped)
        )
    }

    // MARK: - Configure

    private func configure(with task: MockTask) {
        titleLabel.text = task.name
        dayLabel.text = task.dateStart.timeIntervalToDayString()
        timeLabel.text = task.dateStart.timeIntervalToString() + " - " + task.dateFinish.timeIntervalToString()
        descriptionLabel.text = task.description
    }

    // MARK: - Action

    @objc
    func deleteTaskTapped() {
        print("delete task")
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -16),

            dayLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 16),
            dayLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -16),

            timeLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor, constant: -16)
        ])
    }
}
