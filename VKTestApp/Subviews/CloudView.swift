import UIKit

final class CloudView: UIView {
    
    // MARK: - Private properties
    
    private var cloudImageViews = [UIImageView]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if cloudImageViews.isEmpty {
            startCloudAnimation()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupCloudImageViews() {
        for _ in 0..<10 {
            let cloudImageView = UIImageView(image: UIImage(named: "cloud"))
            cloudImageView.contentMode = .scaleAspectFit
            cloudImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(cloudImageView)
            cloudImageViews.append(cloudImageView)
            
            NSLayoutConstraint.activate([
                cloudImageView.widthAnchor.constraint(equalToConstant: 150),
                cloudImageView.heightAnchor.constraint(equalToConstant: 100),
                cloudImageView.centerYAnchor.constraint(equalTo: topAnchor, constant: CGFloat.random(in: 0...bounds.height)),
                cloudImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.random(in: -150...bounds.width))
            ])
        }
    }
    
    // MARK: - Public methods
    
    func startCloudAnimation() {
        setupCloudImageViews()
        for cloudImageView in cloudImageViews {
            let animation = CABasicAnimation(keyPath: "position.x")
            animation.fromValue = -bounds.width
            animation.toValue = bounds.width + cloudImageView.bounds.width
            animation.duration = Double.random(in: 20.0...30.0)
            animation.repeatCount = .infinity
            cloudImageView.layer.add(animation, forKey: "cloudAnimation")
        }
    }
    
    func stopCloudAnimation() {
        for cloudImageView in cloudImageViews {
            cloudImageView.layer.removeAnimation(forKey: "cloudAnimation")
            cloudImageView.removeFromSuperview()
        }
        cloudImageViews.removeAll()
    }
}
