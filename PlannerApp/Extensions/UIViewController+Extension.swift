import UIKit

extension UIViewController {

    // MARK: - Keyboard actions

    @objc
    func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextView = UIResponder.currentFirst() as? UITextView else {
            return
        }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextViewFrame = view.convert(currentTextView.frame, from: currentTextView.superview)
        let textViewBottomY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height

        if textViewBottomY > keyboardTopY {
            let textBoxY = convertedTextViewFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc
    func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}
