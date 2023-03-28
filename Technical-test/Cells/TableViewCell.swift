//
//  TableViewCell.swift
//  Technical-test
//
//  Created by mac on 28.03.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    private let favouriteImageView = UIImageView()
    private let nameLabel = UILabel()
    private let lastLabel = UILabel()
    private let currencyLabel = UILabel()
    private let readableLastChangePercentLabel = UILabel()

    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                                lastLabel,
                                                                currencyLabel,
                                                                readableLastChangePercentLabel])
    private let noFavouriteImage = UIImage(named: "no-favorite")
    private let favouriteImage = UIImage(named: "favorite")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureWith(quote: QuoteFavourite) {
        favouriteImageView.image = quote.isFavourite ? favouriteImage : noFavouriteImage
        nameLabel.text = quote.quote?.name
        lastLabel.text = quote.quote?.last
        currencyLabel.text = quote.quote?.currency
        readableLastChangePercentLabel.text = quote.quote?.readableLastChangePercent
        
        if let color = quote.quote?.variationColor {
            switch color {
            case .red:
                readableLastChangePercentLabel.textColor = .red
            case .green:
                readableLastChangePercentLabel.textColor = .green
            }
        }
    }
}

private extension TableViewCell {
    
    func setupViews() {
        addSubview(favouriteImageView)
        addSubview(nameLabel)
        addSubview(lastLabel)
        addSubview(currencyLabel)
        addSubview(readableLastChangePercentLabel)
        addSubview(stackView)
        
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        
        lastLabel.font = .systemFont(ofSize: 16)
        lastLabel.textAlignment = .left
        
        currencyLabel.font = .systemFont(ofSize: 16)
        currencyLabel.textAlignment = .left
        
        readableLastChangePercentLabel.font = .systemFont(ofSize: 16)
        readableLastChangePercentLabel.textAlignment = .left
        
        favouriteImageView.clipsToBounds = true
        favouriteImageView.contentMode = .scaleAspectFill
        
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
    }
    
    func setupAutoLayout() {
        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favouriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favouriteImageView.heightAnchor.constraint(equalToConstant: 20),
            favouriteImageView.widthAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: favouriteImageView.leadingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
