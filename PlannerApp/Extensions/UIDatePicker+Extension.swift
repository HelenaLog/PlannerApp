import UIKit

extension UIDatePicker {

    static func makeDatePicker(datePickerMode: UIDatePicker.Mode) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = datePickerMode
        datePicker.locale = Locale(identifier: "en_EN")
        datePicker.contentHorizontalAlignment = .left
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }
}
