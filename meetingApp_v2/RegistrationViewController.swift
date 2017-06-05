//
//  RegistrationViewController.swift
//  meetingApp_v2
//
//  Created by Alexander Melekhin on 31.05.17.
//  Copyright © 2017 Alexander Melekhin. All rights reserved.
//

import UIKit

// расширение класса String для коррекции первой буквы строки:
extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
}

////
// класс viewcontroller для регистрации
//
class RegistrationViewController: UIViewController {
    
    // toDo: исправить эти костыли
    var emailIsOk = false
    var passwordIsOk = false
    var nameIsOk = false
    var surnameIsOk = false
    var cityIsOk = false
    var registrationDataIsOk = false
    
    // объявление текстовых полей с данными для регистрации:
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton! // кнопка регистрации
    
    ////
    // костыльная проверка полей с текстом:
    // toDo: исправить костыли
    @IBAction func checkEmail(_ sender: UITextField) {
        // toDo: доработать условие
        if ( (emailTextField.text != nil) && (emailTextField.text?.range(of: "@") != nil)
            && (true)) {
            emailIsOk = true
        }
        else {
            emailIsOk = false
        }
        registerButton.isEnabled = emailIsOk && passwordIsOk && nameIsOk && surnameIsOk && cityIsOk
    }
    
    @IBAction func checkPassword(_ sender: UITextField) { // условие - 6 или больше символов
        if (passwordTextField.text!.characters.count >= 6) {
            passwordIsOk = true
        }
        else {
            passwordIsOk = false
        }
        registerButton.isEnabled = emailIsOk && passwordIsOk && nameIsOk && surnameIsOk && cityIsOk
    }
    @IBAction func checkName(_ sender: UITextField) { // toDo: добавить проверку на лишние символы
        if (nameTextField.text!.characters.count >= 2) {
            nameIsOk = true
            nameTextField.text = nameTextField.text!.uppercaseFirst // исправление первой буквы на большую
        }
        else {
            nameIsOk = false
        }
        registerButton.isEnabled = emailIsOk && passwordIsOk && nameIsOk && surnameIsOk && cityIsOk
    }
    @IBAction func checkSurname(_ sender: UITextField) { // toDo: добавить проверку на лишние символы
        if (surnameTextField.text!.characters.count >= 2) {
            surnameIsOk = true
            surnameTextField.text = surnameTextField.text!.uppercaseFirst // исправление первой буквы на большую
        }
        else {
            surnameIsOk = false
        }
        registerButton.isEnabled = emailIsOk && passwordIsOk && nameIsOk && surnameIsOk && cityIsOk
    }
    @IBAction func checkCity(_ sender: UITextField) { // toDo: добавить проверку на лишние символы, лучше - переделать способ ввода города вообще
        if (cityTextField.text!.characters.count >= 2) {
            cityIsOk = true
            cityTextField.text = cityTextField.text!.uppercaseFirst // исправление первой буквы на большую
        }
        else {
            cityIsOk = false
        }
        registerButton.isEnabled = emailIsOk && passwordIsOk && nameIsOk && surnameIsOk && cityIsOk
    }
    // конец проверки
    ////
    
    ////
    // кнопка регистрации:
    //
    @IBAction func registerAction(_ sender: Any) {
        
        // создание алерта об успехе:
        let alertSuccess = UIAlertController(title: "Registration", message: "Регистрация прошла успешно", preferredStyle: UIAlertControllerStyle.alert)
        alertSuccess.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // создание алерта об ошибке?
        
        
        // создаем переменную со словарем из вводимых данных "ключ-данные", подразумевается, что все введено верно
        let parameters = ["email": emailTextField.text!, "password": passwordTextField.text!, "name": nameTextField.text!, "surname": surnameTextField.text!, "city": cityTextField.text!] as Dictionary<String,String>
       
        // создаем URL
        let url = URL(string: "http://95.221.226.159:8000/register/")
        
        // создаем объект сессии
        let session = URLSession.shared
        
        // создаем URLRequest
        var request = URLRequest(url: url!)
        request.httpMethod = "POST" // устанавливает метод http на POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // передает словарь в nsdata объект и что-то еще делает
            
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        // создает dataTask используя объект session чтобы отправить данные на сервер
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            
            let serverResponse = String(data: data, encoding: String.Encoding.utf8)!
            if (serverResponse == "ok") {
                self.present(alertSuccess, animated: true, completion: nil)
            }
        })
        task.resume()
        
    }
    // конец регистрации
    ////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
