import UIKit

final class FogView: UIView {

    private let fogImageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startFogAnimation()
    }
    
    // MARK: - Private methods

    private func setupUI() {
        fogImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fogImageView)
        setupFogImageView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fogImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fogImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fogImageView.topAnchor.constraint(equalTo: topAnchor),
            fogImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupFogImageView() {
        fogImageView.image = UIImage(named: "fog")
        fogImageView.contentMode = .scaleAspectFill
        fogImageView.alpha = 0.5
    }
    
    // MARK: - Public methods
    
    func startFogAnimation() {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = -bounds.width
        animation.toValue = bounds.width
        animation.duration = 10.0
        animation.repeatCount = .infinity
        fogImageView.layer.add(animation, forKey: "fogAnimation")
    }
}
