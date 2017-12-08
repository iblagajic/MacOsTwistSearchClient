//
//  SearchResultView.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit

class  SearchResultView: NSTableRowView {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var snippetLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }

    private func setStyle() {
        titleLabel.font = .title
        titleLabel.textColor = .primaryText
        snippetLabel.font = .body
        snippetLabel.textColor = .primaryText
        timeLabel.font = .subtitle
        timeLabel.textColor = .primaryText
    }

    func update(with searchResult: SearchResult) {
        titleLabel.stringValue = searchResult.title ?? ""
        snippetLabel.stringValue = searchResult.snippet ?? ""
        if let interval = TimeInterval(exactly: searchResult.last_posted_ts) {
            let date = Date(timeIntervalSince1970: interval)
            timeLabel.stringValue = SearchResultView.dateFormatter.string(from: date)
        }
    }

}
