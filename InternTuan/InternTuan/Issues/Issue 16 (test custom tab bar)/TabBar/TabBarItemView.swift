//
//  TabBarItemView.swift
//  InternTuan
//
//  Created by Tuan on 10/2/26.
//

import UIKit

final class TabBarItemView: UIControl {
    
    private let tab: Tab
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // StackView để chứa Icon và Title
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        stack.isUserInteractionEnabled = false // Để sự kiện touch xuyên qua xuống UIControl
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Badge View (Label đỏ)
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemRed
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 8 // Kích thước 16/2
        label.layer.masksToBounds = true
        label.isHidden = true // Mặc định ẩn
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // State quản lý selected
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    init(tab: Tab) {
        self.tab = tab
        super.init(frame: .zero)
        setupUI()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        addSubview(badgeLabel) // Thêm badge vào view
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Kích thước icon
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            // Badge Constraints (góc trên phải của icon)
            badgeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -8),
            badgeLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -6),
            badgeLabel.heightAnchor.constraint(equalToConstant: 16),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 16) // Co giãn theo text
        ])
    }
    
    // API để set Badge
    func setBadge(_ value: String?) {
        guard let value = value, !value.isEmpty else {
            badgeLabel.isHidden = true
            return
        }
        badgeLabel.text = " \(value) " // Thêm padding text nhẹ
        badgeLabel.isHidden = false
        
        // Animation pop nhẹ khi có badge mới
        badgeLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.badgeLabel.transform = .identity
        }, completion: nil)
    }
    
    private func updateUI() {
        titleLabel.text = tab.title
        
        if isSelected {
            iconImageView.image = tab.selectedIcon
            iconImageView.tintColor = tab.color
            titleLabel.textColor = tab.color
            
            // Animation Bounce (Hiệu ứng nảy)
            // Lần đầu load thì không cần animation (window == nil)
            if window != nil {
                addBounceAnimation()
            }
        } else {
            iconImageView.image = tab.icon
            iconImageView.tintColor = .systemGray
            titleLabel.textColor = .systemGray
        }
    }
    
    private func addBounceAnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 0.85, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = 0.5
        bounceAnimation.calculationMode = .cubic
        
        iconImageView.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}
