import UIKit

protocol WeatherViewControllerDelegate: AnyObject {
    func didTapCell(weather: Weather)
}

final class WeatherViewController: UIViewController {
    
    private let weatherTypeView = WeatherTypeView()
    private let gradientLayer = CAGradientLayer()
    private let fogView = FogView()
    private let rainView = RainView()
    private let lightningView = LightningView()
    private let sunView = SunView()
    private var cloudView = CloudView()
    
    var weather = Weather.allCases.randomElement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        weatherTypeView.delegate = self
    }
    
    private func setupUI() {
        var colors = [CGColor]()
        colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        gradientLayer.colors = colors
        setupViews()
        setupConstraints()
        setupGradientLayer()
        fogView.startFogAnimation()
        rainView.stopRainAnimation()
        sunView.alpha = 0
        cloudView.stopCloudAnimation()
        cloudView.alpha = 0
        guard let weather else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.setGradientColors(weather: weather)
            self?.setupWeather(weather: weather)
        }
    }
    
    private func setupViews() {
        fogView.translatesAutoresizingMaskIntoConstraints = false
        rainView.translatesAutoresizingMaskIntoConstraints = false
        lightningView.translatesAutoresizingMaskIntoConstraints = false
        weatherTypeView.translatesAutoresizingMaskIntoConstraints = false
        sunView.translatesAutoresizingMaskIntoConstraints = false
        cloudView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fogView)
        view.addSubview(rainView)
        view.addSubview(lightningView)
        view.addSubview(weatherTypeView)
        view.addSubview(sunView)
        view.addSubview(cloudView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherTypeView.heightAnchor.constraint(equalToConstant: 60),
            
            
            fogView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fogView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fogView.topAnchor.constraint(equalTo: view.topAnchor),
            fogView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rainView.topAnchor.constraint(equalTo: view.topAnchor),
            rainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lightningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lightningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lightningView.topAnchor.constraint(equalTo: view.topAnchor),
            lightningView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            sunView.widthAnchor.constraint(equalToConstant: 300),
            sunView.heightAnchor.constraint(equalToConstant: 300),
            sunView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sunView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            cloudView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cloudView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cloudView.topAnchor.constraint(equalTo: view.topAnchor),
            cloudView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupGradientLayer() {
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setGradientColors(weather: Weather) {
        var colors = [CGColor]()
        
        switch weather {
        case .fog:
            colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        case .rain:
            colors = [UIColor.gray.cgColor, UIColor.lightGray.cgColor]
        case .lightning:
            colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        case .sun:
            colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor]
        case .cloud:
            colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor]
        }
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = colors
        animation.duration = 1.0
        gradientLayer.add(animation, forKey: "colorsChange")
        gradientLayer.colors = colors
    }
    
    private func setupWeather(weather: Weather) {
        switch weather {
        case .fog:
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.fogView.alpha = 1
                self?.sunView.alpha = 0
                self?.cloudView.alpha = 0
            }
            rainView.stopRainAnimation()
            lightningView.stopLightningAnimation()
            sunView.stopSunAnimation()
            cloudView.stopCloudAnimation()
        case .rain:
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.fogView.alpha = 0
                self?.sunView.alpha = 0
                self?.cloudView.alpha = 0
            }
            rainView.startRainAnimation()
            lightningView.stopLightningAnimation()
            sunView.stopSunAnimation()
            cloudView.stopCloudAnimation()
        case .lightning:
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.fogView.alpha = 0
                self?.sunView.alpha = 0
                self?.cloudView.alpha = 0
            }
            rainView.startRainAnimation()
            lightningView.startLightningAnimation()
            sunView.stopSunAnimation()
            cloudView.stopCloudAnimation()
        case .sun:
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.fogView.alpha = 0
                self?.sunView.alpha = 1
                self?.cloudView.alpha = 0
            }
            rainView.stopRainAnimation()
            lightningView.stopLightningAnimation()
            sunView.startSunAnimation()
            cloudView.stopCloudAnimation()
        case .cloud:
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.fogView.alpha = 0
                self?.sunView.alpha = 0
                self?.cloudView.alpha = 1
            }
            rainView.stopRainAnimation()
            lightningView.stopLightningAnimation()
            sunView.stopSunAnimation()
            cloudView.startCloudAnimation()
        }
    }
}

extension WeatherViewController: WeatherViewControllerDelegate {
    func didTapCell(weather: Weather) {
        setGradientColors(weather: weather)
        setupWeather(weather: weather)
    }
}
