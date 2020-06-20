import UIKit
import SwiftUI

class DateTextField: UITextField {
    // MARK: - Public properties
    @Binding var date: Date?

    // MARK: - Initializers
    init(date: Binding<Date?>) {
        self._date = date
        super.init(frame: .zero)

        if let date = date.wrappedValue {
            self.datePickerView.date = date
        }

        self.datePickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

        self.inputView = datePickerView
        self.inputAccessoryView = toolbar
        self.tintColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties
    private lazy var datePickerView: UIDatePicker = {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        return datePickerView
    }()

    private lazy var toolbar: UIToolbar = {
         let toolBar = UIToolbar()
         toolBar.barStyle = .default
         toolBar.isTranslucent = true
         toolBar.tintColor = .systemBlue
         toolBar.isUserInteractionEnabled = true

         let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         toolBar.setItems([spaceButton, doneButton], animated: false)

         toolBar.sizeToFit()
         return toolBar
     }()

    // MARK: - Private methods
    @objc
    private func donePressed() {
        self.date = datePickerView.date
        self.endEditing(true)
    }

    @objc func dateChanged(_ sender: UIDatePicker) {
        self.date = sender.date
    }
}
