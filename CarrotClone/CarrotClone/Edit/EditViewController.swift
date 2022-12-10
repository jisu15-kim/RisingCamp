//
//  EditViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit
import PhotosUI

enum EditStatus {
    case modify
    case write
}

class EditViewController: UIViewController {
    
    var item: TradeItemModel?
    var status: EditStatus?
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(confirmButton(_:)))
        
        return button
    }()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var gallaryPickImage: UIImageView!
    
    @IBOutlet weak var categoryPickLabel: UILabel!
    @IBOutlet weak var categoryPickView: UIView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    private var category: Category? {
        didSet {
            categoryPickLabel.text = category?.rawValue
        }
    }
    
    var selectedImage: [UIImage] = []
    
    var bodyPlaceHolder: String = "시흥동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationItem.title = "중고거래 글쓰기"
        setupBodyTextField()
        setupTextField()
        setupGallaryPick()
        setupCategoryPickView()
        configureUI()
    }
    
    private func setupBodyTextField() {
        bodyTextView.delegate = self
        
        // 화면 초기 로드시
        bodyTextView.text = bodyPlaceHolder
        bodyTextView.textColor = .gray
    }
    
    private func setupCategoryPickView() {
        categoryPickView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openCategoryPickerView(_:)))
        categoryPickView.addGestureRecognizer(gesture)
    }
    
    private func setupTextField() {
        titleTextField.borderStyle = .none
        priceTextField.borderStyle = .none
        
        titleTextField.addLeftPadding(leading: 5)
        priceTextField.addLeftPadding(leading: 5)
        priceTextField.keyboardType = .numberPad
        priceTextField.delegate = self
    }
    
    private func setupGallaryPick() {
        gallaryPickImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.openGallary(_:)))
        gallaryPickImage.addGestureRecognizer(gesture)
    }
    
    @objc private func openGallary(_ sender: UITapGestureRecognizer) {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func openCategoryPickerView(_ sender: UITapGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryPickViewController") as? CategoryPickViewController else { return }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func confirmButton(_ sender: Any) {
        self.writeItem()
        self.navigationController?.popViewController(animated: true, completion: {
            self.delegate?.didEditFinished()
        })
    }
    
    private func writeItem() {
        let status = checkEssential()
        print("필수조건: \(status)")
        // 필수 조건들 충족
        if status == true {
            let title = titleTextField.text
            let user = User(name: UserInfo.shared.getUserName())
            let region = "서울특별시 송파구" // 확인
            let photos = [gallaryPickImage.image!]
            let category = self.category ?? Category.digital
            let price = "\(priceTextField.text ?? "??")원"
            let isPriceSuggest = true // 확인
            let body = bodyTextView.text
            let place = ""
            
            if self.status == .write {
                // 쓰기일때
                let newItem = TradeItemModel(title: title ?? "", user: user, region: region, photos: photos, category: category, price: price, isPriceSuggest: isPriceSuggest, body: body ?? "", place: place)
                TradeItemLogic.shared.createItem(item: newItem)
            } else {
                // 수정일때
                let config = TradeItemConfig(id: self.item!.id, title: title ?? "", user: user, region: self.item!.region, photos: photos, category: category, price: price, isPriceSuggest: isPriceSuggest, body: body ?? "", place: place)
                TradeItemLogic.shared.updateItem(config: config)
            }
        } else {
            // 필수조건 미충족
            let alert = UIAlertController(title: "완료할 수 없습니다", message: "빈 칸들을 채워주세요", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
            
        }
        
    }
    
    private func checkEssential() -> Bool {
        if titleTextField.text == "" || priceTextField.text == "" || gallaryPickImage.image == nil {

            return false
        } else {
            return true
        }
    }
    
    private func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
    
    //MARK: MyItemVC에서 push했을 때 내용을 채우는 함수
    public func configureUI() {
        if let item = self.item {
            self.titleTextField.text = item.title
            self.priceTextField.text = item.price?.trimmingCharacters(in: ["원"])
            self.bodyTextView.text = item.body
            self.category = item.category
            self.gallaryPickImage.image = item.photos![0] // 확인
            bodyTextView.textColor = .label
        }
    }
}

extension EditViewController: CategoryPickDelegate {
    func categoryPicked(selected: Category) {
        self.category = selected
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bodyTextView.text == bodyPlaceHolder {
            bodyTextView.text = nil
            bodyTextView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bodyTextView.text.isEmpty {
            bodyTextView.text = bodyPlaceHolder
            bodyTextView.textColor = .gray
        }
    }
}

extension EditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var check = true
        
        if textField == priceTextField {
            // 지우기 일 경우..
            if string == "" {
                return true
            } else if (Int(string) == nil) {
                print("숫자만 입력 가능합니다")
                check = false
            }
        }
        return check
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if let current = Int(textField.text?.components(separatedBy: ",").joined() ?? "") {
            priceTextField.text = priceToDecimal(price: current)
        } else {
            priceTextField.text = nil
        }
    }
}

extension EditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    guard let data = image as? UIImage else { return }
                    self.selectedImage.append(data)
                    self.gallaryPickImage.image = data // 5
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
