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
                guard let proxy = self?.textDocumentProxy else { return }
                if proxy.documentContextBeforeInput != nil {
                    proxy.deleteBackward()
                }
            },
            clearAll: { [weak self] in
                guard let proxy = self?.textDocumentProxy else { return }
                while proxy.documentContextBeforeInput != nil {
                    proxy.deleteBackward()
                }
            },
            nextKeyboard: { [weak self] (view: UIView, event: UIEvent?) in
                self?.handleInputModeList(from: view, with: event ?? UIEvent())
            }
        )

        view.addSubview(rootView)
        rootView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.reload()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
