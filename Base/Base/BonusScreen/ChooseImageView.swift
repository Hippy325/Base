//
//  ChooseImageView.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import UIKit

final class ChooseImageView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: BonusModel.getImagesName(index: index))
        return view
    }()
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let index: Int
    var isActive: Bool
    var closure: ((Int) -> Void)
    
    init(index: Int, isActive: Bool, closure: @escaping ((Int) -> Void)) {
        self.closure = closure
        self.index = index
        self.isActive = isActive
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOn)))
        selectedView.alpha = isActive ? 0 : 0.7
        addSubview(imageView, top: 0)
        addSubview(selectedView, top: 0)
    }
    
    func configure(isActive: Bool) {
        selectedView.alpha = isActive ? 0 : 0.7
    }
    
    @objc private func tapOn() {
        closure(index)
    }
}
