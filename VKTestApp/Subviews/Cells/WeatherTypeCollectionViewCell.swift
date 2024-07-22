import UIKit

final class WeatherTypeCollectionViewCell: UICollectionViewCell {
    
    static let weatherTypeCellIdentifier = "WeatherTypeCell"
    
    // MARK: - Private properties
    
    private lazy var weatherTypeLabel: UILabel = {
        let weatherTypeLabel = UILabel()
        weatherTypeLabel.textAlignment = .center
        weatherTypeLabel.textColor = .white
        return weatherTypeLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        weatherTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherTypeLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Public methods
    
    func configure(weather: String) {
        weatherTypeLabel.text = weather
    }
}
