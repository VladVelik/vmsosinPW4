//
//  NoteCell.swift
//  vmsosinPW2
//
//  Created by Sosin Vladislav on 12.10.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var noteText: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        textView.textColor = .black
        textView.backgroundColor = .systemGray5
        return textView }()
    
    override init(style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .systemGray5
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        noteText.isScrollEnabled = false
        self.addSubview(self.noteText)
        noteText.pin(to: self,
            [.left: 10, .right: 10, .bottom: 20, .top: 20]
        )
    }
    
    public func configure(note: ShortNote) {
        self.noteText.text = note.text
    }
}
