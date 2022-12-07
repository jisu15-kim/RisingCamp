//
//  EditViewController.swift
//  CarrotClone
//
//  Created by 김지수 on 2022/12/05.
//

import UIKit

class EditViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var bodyPlaceHolder: String = "시흥동에 올릴 게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "중고거래 글쓰기"
        setupBodyTextField()
        setupTextField()
    }
    
    private func setupBodyTextField() {
        bodyTextView.delegate = self
        
        // 화면 초기 로드시
        bodyTextView.text = bodyPlaceHolder
        bodyTextView.textColor = .gray
    }
    
    private func setupTextField() {
        titleTextField.borderStyle = .none
        priceTextField.borderStyle = .none
        
        titleTextField.addLeftPadding(leading: 5)
        priceTextField.addLeftPadding(leading: 5)
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
