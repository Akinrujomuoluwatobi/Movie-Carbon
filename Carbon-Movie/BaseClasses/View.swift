//
//  View.swift
//

import UIKit

class View: UIView {

    var withAction: (() -> Void)? {
        didSet {
            guard withAction != nil else { return }
            isUserInteractionEnabled = true
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performAction)))
        }
    }    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        setupViewHierarchy()
        setupConstraints()
        setupProperties()
        //(self as? UITestsIdentifiable)?.setupIdentifiers()
    }

    func setupViewHierarchy() {
        abstractMethod()
    }

    func setupConstraints() {
        abstractMethod()
    }

    /// Optional method.
    func setupProperties() { }

    @objc func performAction() {
        withAction?()
    }

}
