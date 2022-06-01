//
//  LoginInspector.swift
//  Navigation
//
//  Created by t.lolaev on 16.01.2022.
//

import CurrentUserService

protocol LoginViewControllerDelegate {
    
    func checkCredentials(username: String, password: String, callback: @escaping CheckCredentialsCallback) -> Void
    func bruteForce(passwordToUnlock: String)
    
}

class LoginInspector: LoginViewControllerDelegate {
    
    public func checkCredentials(username: String, password: String, callback: @escaping CheckCredentialsCallback) -> Void {
        let checkerService = CheckerService.shared
        
        checkerService.checkCredentials(username: username, password: password, callback: callback)
    }
    
    public func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        index < array.count ? Character(array[index]) : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        } else {
            str.replace(at: str.count - 1, with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
}
