//
//  SearchResultView.swift
//  TwistSearchClient
//
//  Created by Ivan Blagajić on 07/12/2017.
//  Copyright © 2017 Five Dollar Milkshake. All rights reserved.
//

import AppKit

class  SearchResultView: NSTableRowView {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var snippetLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }

    private func setStyle() {
        titleLabel.font = NSFont.title()
        titleLabel.textColor = NSColor.primaryText()
        snippetLabel.font = NSFont.body()
        snippetLabel.textColor = NSColor.primaryText()
        timeLabel.font = NSFont.subtitle()
        timeLabel.textColor = NSColor.primaryText()
    }

    func update(with searchResult: SearchResult) {
        titleLabel.stringValue = searchResult.title ?? ""
        snippetLabel.stringValue = searchResult.snippet ?? ""
        if let interval = TimeInterval(exactly: searchResult.last_posted_ts) {
            let date = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            timeLabel.stringValue = dateFormatter.string(from: date)
        }
    }

}
