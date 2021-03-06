//
//  ViewController.swift
//  hurigana
//
//  Created by 佐野哲也 on 2020/04/12.
//  Copyright © 2020 佐野哲也. All rights reserved.
//

import UIKit

struct Rubi:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}
struct PostData: Codable {
    var app_id:String
    var request_id: String
    var sentence: String
    var output_type: String
}
class ViewController: UIViewController {

    @IBOutlet var textField: UITextField! //文字入力部分
    var  inputText: String! //入力文字
    @IBOutlet var outputText: UILabel! //ひらがなに変換した後のテキスト
    override func viewDidLoad() {
        super.viewDidLoad()
        //画面初期起動時には出力結果を隠します。
        outputText.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(_ sender: Any) {
        inputText = textField.text!
        
        // URLRequstの設定
        var request = URLRequest(url: URL(string: "https://labs.goo.ne.jp/api/hiragana")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //POSTするデータをURLRequestに持たせる
        let postData = PostData(app_id: "8b90aa7f78d3bceb571631b29757833963a5e82b8df687f35eca4423bf2d7e09", request_id: "record003", sentence: inputText, output_type: "hiragana")
        guard let uploadData = try? JSONEncoder().encode(postData) else {
            print("json生成に失敗しました")
            return
        }
            request.httpBody = uploadData
            //APIへPOSTしてresponseを受け取る
            let task = URLSession.shared.uploadTask(with: request, from: uploadData) {
                data, response, error in
                if let error = error {
                    print ("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        print ("server error")
                        return
                }
                if response.statusCode == 200 {
                    guard let data = data, let jsonData = try? JSONDecoder().decode(Rubi.self, from: data) else {
                        print("json変換に失敗しました")
                        return
                    }
                    print(jsonData.converted)
                    DispatchQueue.main.async {
                        //json変換に成功した時に結果を表示する。
                        self.outputText.isHidden = false
                        self.outputText.text = jsonData.converted
                    }
                } else {
                    print("サーバエラー ステータスコード: \(response.statusCode)\n")
                }
            }
            task.resume()
    }
    
}

