import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - property
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - flow funcs
    private func configure() {
        configureImageView()
        configureView()
        configureLabel()
    }

    private func configureImageView() {
        categoryImageView.rounded(radius: 12)
    }

    private func configureView() {
        shadowView.rounded(radius: 12)
        shadowView.backgroundColor = .specialBlack
        shadowView.alpha = 0.36
    }

    private func configureLabel() {
        categoryNameLabel.text = "Category"
        categoryNameLabel.textColor = .white
        categoryNameLabel.font = .poppinsBold24()
    }
}
