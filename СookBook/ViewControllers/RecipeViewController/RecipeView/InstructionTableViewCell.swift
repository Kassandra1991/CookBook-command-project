import UIKit

class InstructionTableViewCell: UITableViewCell {
    // MARK: - property
    @IBOutlet weak var instructionLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - flow funcs
    func configureLabel() {
        instructionLabel.textColor = .specialBlack
        instructionLabel.font = .poppinsRegular14()
    }
}
