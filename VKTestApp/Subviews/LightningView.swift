import UIKit

final class LightningView: UIView {
    
    // MARK: - Private properties

    private let lightningEmitterLayer = CAEmitterLayer()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLightningEmitter()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lightningEmitterLayer.frame = bounds
        lightningEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        lightningEmitterLayer.emitterSize = CGSize(width: bounds.width, height: bounds.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupLightningEmitter() {
        let lightningCell = CAEmitterCell()
        lightningCell.contents = UIImage(named: "lightning")?.cgImage
        lightningCell.birthRate = 2
        lightningCell.lifetime = 0.2
        lightningCell.velocity = 0
        lightningCell.scale = 0.5
        lightningCell.emissionRange = .pi * 2
        
        lightningEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        lightningEmitterLayer.emitterSize = CGSize(width: bounds.width, height: bounds.height)
        lightningEmitterLayer.emitterShape = .rectangle
        lightningEmitterLayer.emitterCells = [lightningCell]
        
        layer.addSublayer(lightningEmitterLayer)
        lightningEmitterLayer.opacity = 0
    }
    
    // MARK: - Public methods
    
    func startLightningAnimation() {
        lightningEmitterLayer.opacity = 1
        let flashAnimation = CABasicAnimation(keyPath: "opacity")
        flashAnimation.fromValue = 0.0
        flashAnimation.toValue = 1.0
        flashAnimation.duration = 0.1
        flashAnimation.autoreverses = true
        flashAnimation.repeatCount = .greatestFiniteMagnitude
        lightningEmitterLayer.add(flashAnimation, forKey: "flashAnimation")
    }
    
    func stopLightningAnimation() {
        lightningEmitterLayer.opacity = 0
        lightningEmitterLayer.removeAnimation(forKey: "flashAnimation")
    }
}
