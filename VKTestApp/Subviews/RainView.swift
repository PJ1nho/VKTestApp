import UIKit

final class RainView: UIView {
    
    // MARK: - Private properties
    
    private let rainEmitterLayer = CAEmitterLayer()
    
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
        rainEmitterLayer.frame = bounds
        rainEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -10)
        rainEmitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        setupRainEmitter()
    }
    
    private func setupRainEmitter() {
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(named: "raindrop")?.cgImage
        rainCell.birthRate = 40
        rainCell.lifetime = 4.0
        rainCell.velocity = 300
        rainCell.velocityRange = 50
        rainCell.scale = 0.05
        rainCell.scaleRange = 0.02
        rainCell.emissionRange = .pi / 16
        rainCell.emissionLongitude = .pi
        
        rainEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: -10)
        rainEmitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
        rainEmitterLayer.emitterShape = .line
        rainEmitterLayer.beginTime = CACurrentMediaTime()
        rainEmitterLayer.timeOffset = 10.0
        rainEmitterLayer.emitterCells = [rainCell]
        
        layer.addSublayer(rainEmitterLayer)
        rainEmitterLayer.opacity = 0
    }
    
    // MARK: - Public methods
    
    func startRainAnimation() {
        rainEmitterLayer.opacity = 1
    }
    
    func stopRainAnimation() {
        rainEmitterLayer.opacity = 0
    }
}
