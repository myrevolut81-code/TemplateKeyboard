import UIKit

final class KeyboardViewController: UIInputViewController {

    private var rootView: KeyboardRootView!

    override func viewDidLoad() {
        super.viewDidLoad()

        TemplateStore.shared.load()

        rootView = KeyboardRootView(
            insertText: { [weak self] text in
                self?.textDocumentProxy.insertText(text)
            },
            deleteBackward: { [weak self] in
                self?.textDocumentProxy.deleteBackward()
            },
            clearAll: { [weak self] in
                guard let proxy = self?.textDocumentProxy else { return }
                while proxy.documentContextBeforeInput != nil {
                    proxy.deleteBackward()
                }
            },
            nextKeyboard: { [weak self] view, event in
                self?.handleInputModeList(from: view, with: event ?? UIEvent())
            }
        )

        rootView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rootView)

        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
