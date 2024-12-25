import UIKit

final class CreateTaskViewController: UIViewController {

    var presenter: CreateTaskViewPresenterProtocol!

    // MARK: - Private Visual Components

    private let taskNameLabel: UILabel = .makeTitleLabel(text: "Task Name", textColor: .black)
    private let dateLabel: UILabel = .makeTitleLabel(text: "Date", textColor: .black)
    private let startTimeLabel: UILabel = .makeTitleLabel(text: "Start Time", textColor: .black)
    private let finishTimeLabel: UILabel = .makeTitleLabel(text: "Finish Time", textColor: .black)
    private let descriptionLabel: UILabel = .makeTitleLabel(text: "Description", textColor: .black)

    private let datePicker: UIDatePicker = .makeDatePicker(datePickerMode: .date)
    private let startTimePicker: UIDatePicker = .makeDatePicker(datePickerMode: .time)
    private let finishTimePicker: UIDatePicker = .makeDatePicker(datePickerMode: .time)

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderWidth = 0.25
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 2.5
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
        embedViews()
        setupLayout()
        setupNavigationBar()
        setupTapGestureRecognizer()
        addKeyboardObservers()
        setupTextFieldDelegate()
    }

    deinit {
        print("deinit CreateTaskViewController")
    }

    // MARK: - Embed views

    private func embedViews() {
        view.backgroundColor = .white
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

    // MARK: - Setup Keyboard Hiding

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func setupTextFieldDelegate() {
        taskNameTextField.delegate = self
    }

    // MARK: - Action

    @objc
    func saveTaskTapped() {
        presenter.saveTaskWith(
            dateStart: datePicker.date,
            timeStart: startTimePicker.date,
            timeFinish: finishTimePicker.date,
            name: taskNameTextField.text ?? "",
            description: descriptionTextView.text
        )
    }

    @objc
    func keyboardDismiss() {
        presenter.didTapOutsideKeyboard()
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

// MARK: - UITextFieldDelegate

extension CreateTaskViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskNameTextField {
            descriptionTextView.becomeFirstResponder()
        }
        return true
    }
}

// MARK: - CreateTaskViewProtocol

extension CreateTaskViewController: CreateTaskViewProtocol {

    func hideKeyboard() {
        view.endEditing(true)
    }
}
