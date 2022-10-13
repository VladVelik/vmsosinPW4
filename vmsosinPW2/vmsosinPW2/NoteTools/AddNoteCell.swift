//
//  AddNoteCell.swift
//  vmsosinPW2
//
//  Created by Sosin Vladislav on 12.10.2022.
//

import UIKit

extension AddNoteCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add note"
            textView.textColor = UIColor.lightGray
        }
    }
}

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    var delegate: AddNoteDelegate?
    var pressAction: (() -> Void)?
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        self.selectionStyle = .none
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        textView.text = "Add note"
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .lightGray
        textView.backgroundColor = .clear
        textView.setHeight(to: 130)
        textView.delegate = self
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.addButtonTapped(_:))
        )
        addGestureRecognizer(tapRecognizer)
        addButton.isEnabled = false
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(
            to: contentView,
            [.top: 16, .left: 16, .bottom: 16, .right: 16]
        )
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    private func addButtonTapped(_ sender: UITapGestureRecognizer? = nil) {
        if self.textView.textColor != UIColor.lightGray && self.textView.text.isEmpty == false {
            delegate?.newNoteAdded(note: ShortNote(text: textView.text))
            self.textView.text = "Add note"
            self.textView.textColor = UIColor.lightGray
            pressAction?()
        }
    }
}
