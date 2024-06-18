//
//  ContentSizedTableView.swift
//  SportsStates
//
//  Created by Тигран Гарибян on 13.06.2024.
//

import UIKit

class ContentSizedTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
