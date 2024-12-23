import UIKit

final class CreateTaskViewController: UIViewController {

    // MARK: - Private Visual Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Task Name"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name Task"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Time"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let finishTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "End Time"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .date
        pickerView.locale = Locale(identifier: "en_EN")
        pickerView.contentHorizontalAlignment = .left
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let startTimePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.contentHorizontalAlignment = .left
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let finishTimePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.contentHorizontalAlignment = .left
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        embedViews()
        setupLayout()
        setupNavigationBar()
        setupTapGestureRecognizer()
    }

    // MARK: - Embed views

    private func embedViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        [
            taskNameLabel,
            taskNameTextField,
            descriptionLabel,
            descriptionTextView,
            dateLabel,
            datePicker,
            startTimeLabel,
            startTimePicker,
            finishTimeLabel,
            finishTimePicker
        ].forEach { stackView.addArrangedSubview($0) }
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        title = "Create New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTaskTapped)
        )
    }

    // MARK: - Setup Tap Gesture Recognizer

    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Action

    @objc
    func saveTaskTapped() {
        print("Save task")
    }

    @objc
    func keyboardDismiss() {
        view.endEditing(true)
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

            stackView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
