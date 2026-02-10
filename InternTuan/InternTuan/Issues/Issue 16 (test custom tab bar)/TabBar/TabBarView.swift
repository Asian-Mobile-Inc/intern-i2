//
//  TabBarView.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import Foundation
import UIKit

final class TabBarView: UIView {
    
    weak var delegate: TabBarViewDelegate?
     
     private let stackView: UIStackView = {
         let stack = UIStackView()
         stack.axis = .horizontal
         stack.distribution = .fillEqually
         stack.alignment = .fill
         return stack
     }()
     
     override func awakeFromNib() {
         super.awakeFromNib()
     }
     
     // Lưu reference các item view thay vì button
     private var itemViews: [TabBarItemView] = []
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupUI()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setupUI()
     }
    
    private func setupUI() {
        backgroundColor = .systemBackground // Đổi thành màu nền chuẩn (thường là trắng/đen)
        
        // Thêm Shadow (Đổ bóng)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1 // Độ mờ của bóng (10%)
        layer.shadowOffset = CGSize(width: 0, height: -3) // Bóng đổ lên trên
        layer.shadowRadius = 8 // Độ lan tỏa của bóng
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setupTabs()
    }
    
    private func setupTabs() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        itemViews.removeAll()
        
        for tab in Tab.allCases {
            let itemView = TabBarItemView(tab: tab)
            
            // Gắn tag để biết view nào
            itemView.tag = tab.rawValue
            
            // UIControl cũng dùng addTarget như Button
            itemView.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(itemView)
            itemViews.append(itemView)
        }
    }
    
    @objc private func didTapTab(_ sender: TabBarItemView) {
        guard let tab = Tab(rawValue: sender.tag) else { return }
        delegate?.tabBarView(self, didSelect: tab)
    }
    
    // Hàm update UI
    func updateUI(selectedIndex: Int) {
        itemViews.forEach { $0.isSelected = false }
        if selectedIndex < itemViews.count {
            itemViews[selectedIndex].isSelected = true
        }
    }
    
    // Hàm set badge cho một tab cụ thể
    func setBadge(_ value: String?, for tab: Tab) {
        // Tìm item view tương ứng
        if let itemView = itemViews.first(where: { $0.tag == tab.rawValue }) {
            itemView.setBadge(value)
        }
    }
}

