import UIKit

final class SunView: UIView {
    
    // MARK: - Private properties

    private let sunImageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startSunAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        sunImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sunImageView)
        setupSunImageView()
        setupConstraints()
    }
    
    private func setupSunImageView() {
        sunImageView.image = UIImage(named: "sun")
        sunImageView.contentMode = .scaleAspectFit
        sunImageView.alpha = 0
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sunImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sunImageView.topAnchor.constraint(equalTo: topAnchor),
            sunImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Public methods
    
    func startSunAnimation() {
        sunImageView.alpha = 1
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = sunImageView.layer.position.y - 20
        animation.toValue = sunImageView.layer.position.y + 20
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        sunImageView.layer.add(animation, forKey: "sunAnimation")
    }
    
    func stopSunAnimation() {
        sunImageView.alpha = 0
        sunImageView.layer.removeAnimation(forKey: "sunAnimation")
    }
}
