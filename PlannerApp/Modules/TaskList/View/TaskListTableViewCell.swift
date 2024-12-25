import UIKit

final class TaskListTableViewCell: UITableViewCell {

    static let identifier = "TaskListTableViewCell"

    // MARK: - Private Visual Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.blue.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 2.5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let taskNameLabel: UILabel = .makeTitleLabel(text: .none, textColor: .blue)
    private let timeLabel: UILabel = .makeSubtitleLabel(text: .none, textColor: .black)

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        taskNameLabel.text = nil
        timeLabel.text = nil
    }

    // MARK: - Embed views

    private func embedViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(timeLabel)
    }

    // MARK: - Configure

    func configure(with task: TaskRealm) {
        selectionStyle = .none
        taskNameLabel.text = task.name
        timeLabel.text = task.dateStart.timeToString() + " - " + task.dateFinish.timeToString()
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            taskNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            taskNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            taskNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            timeLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
