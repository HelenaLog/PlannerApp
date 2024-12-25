import UIKit

final class TaskListTableViewCell: UITableViewCell {

    static let identifier = "TaskListTableViewCell"

    // MARK: - Private Visual Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        titleLabel.text = nil
        timeLabel.text = nil
    }

    // MARK: - Embed views

    private func embedViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
    }

    // MARK: - Configure

    func configure(with task: TaskRealm) {
        selectionStyle = .none
        titleLabel.text = task.name
        timeLabel.text = task.dateStart.timeToString() + " - " + task.dateFinish.timeToString()
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
