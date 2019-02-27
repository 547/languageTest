//
//  LanguageTool.swift
//  languageTest
//
//  Created by seven on 2019/2/27.
//  Copyright © 2019 seven. All rights reserved.
//

import Foundation
class LanguageTool {
    enum LocalLanguage: String {
        case en = "en"
        case ch = "zh-Hans"
        case ch_hk = "zh-HK"
    }
    ///默认语言
    static var defaultLanguage = LocalLanguage.en
    static let `default` = LanguageTool.init()
    
    var currentLanguage:LocalLanguage = .en{
        didSet{
            if oldValue != currentLanguage {
                changeLocalLanguage(currentLanguage)
            }
        }
    }
    private var bundle:Bundle?{
        return getBundleWithLanguage(currentLanguage)
    }
    
    let languageKey = "LANGUAGE"
    let languageChangedNotificationNameKey = "LANGUAGE_CHANGED"
    let languageFileName = "Localizable"
    
    private init() {
        currentLanguage = getLanguage()
    }
}
extension LanguageTool {
    func getValueWithKey(_ key:String) -> String? {
        var result:String? = nil
        result = bundle?.localizedString(forKey: key, value: nil, table: languageFileName)
        return result
    }
}
private extension LanguageTool {
    func resetLanguage(_ language:LocalLanguage) -> () {
        let userDefault = UserDefaults.standard
        userDefault.set(language.rawValue, forKey: languageKey)
        userDefault.synchronize()
    }
    func getLanguage() -> LocalLanguage {
        var result = LanguageTool.defaultLanguage
        let userDefault = UserDefaults.standard
        if let value = userDefault.value(forKey: languageKey) as? String, let newResult = LocalLanguage.init(rawValue: value) {
            result = newResult
        }else{
            changeLocalLanguage(result)
        }
        return result
    }
    func getBundleWithLanguage(_ language:LocalLanguage) -> Bundle? {
        var result:Bundle? = nil
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") else { return result }
        result = Bundle.init(path: path)
        return result
    }
}
private extension LanguageTool {
    func postNotification() -> () {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: languageChangedNotificationNameKey), object: nil)
    }
}
private extension LanguageTool {
    func changeLocalLanguage(_ language:LocalLanguage) -> () {
        resetLanguage(language)
        postNotification()
    }
}

