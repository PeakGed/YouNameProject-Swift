//
//  Guest.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation
import UIKit

struct Guest: Codable {
    
    let id: Int
    let titleCode: String?
    let firstName: String
    let midName: String
    let lastName: String
    let nickName: String
    var nationalityCode: String   // alpha-3 code ex."THA"
    let countryCode: String   // alpha-3 code ex."THA"
    let birthdate: Date?
    let citizenCardID: String
    let passportNo: String
    let gender: Gender
    let email: String
    let phone: String
    let address: Address
    let occupation: String
    let note: String
    let hotelID: Int
    let companyID: Int?
    let isHidden: Bool
    let createdAt: Date
    let updatedAt: Date
    
    var isFirst: Bool
    
    var titleLocalizeByNationality: String? {
        if let code = titleCode,
           code.count > 0 {
            if let title = NameTitleList.shared.title(key: code) {
                return isForeigner ? title.enTitle : title.thTitle
            }
            
            return code
        }
        
        return nil
    }
    
    var fullName: String {
        var fullname: String = ""
        
        if firstName.count > 0 {
            fullname += firstName
        }
        if midName.count > 0 {
            fullname += " \(midName)"
        }
        if lastName.count > 0 {
            fullname += " \(lastName)"
        }
        
        return fullname
    }
    
    var titleFullName: String {
        let title: String = titleLocalizeByNationality ?? ""
         
        return "\(title) \(fullName)"
    }
    
    var identityID: String {
        isThaiCitizen ? citizenCardID : passportNo
    }
    
    var nationalityInfo: Nationality {
        Nationality(nationalityCode: nationalityCode,
                    countryCode: countryCode)
    }
    
    var isThaiCitizen: Bool {
        countryCode == "THA"
    }
    
    var isForeigner: Bool {
       isThaiCitizen == false
    }
    
    var age: Int? {
        guard
            let _birthdate = birthdate
        else { return nil }
        
        let now = Date()
        let ageComponents = Calendar.current.dateComponents([.year],
                                                            from: _birthdate,
                                                            to: now)
        guard
            let year = ageComponents.year,
              year > 0
        else { return nil }
        
        return ageComponents.year
    }
    
    init(id: Int,
         titleCode: String?,
         firstName: String,
         midName: String,
         lastName: String,
         nickName: String,
         nationalityCode: String = "THA",
         countryCode: String = "THA",
         birthdate: Date?,
         citizenCardID: String,
         passportNo: String,
         gender: Gender,
         email: String,
         phone: String,
         note: String,
         hotelID: Int,
         companyID: Int?,
         isFirst: Bool,
         isHidden: Bool,
         address: Address,
         occupation: String,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.titleCode = titleCode
        self.firstName = firstName
        self.midName = midName
        self.lastName = lastName
        self.nickName = nickName
        self.nationalityCode = nationalityCode
        self.countryCode = countryCode
        self.birthdate = birthdate
        self.citizenCardID = citizenCardID
        self.passportNo = passportNo
        self.gender = gender
        self.email = email
        self.phone = phone
        self.address = address
        self.occupation = occupation
        self.note = note
        self.hotelID = hotelID
        self.companyID = companyID
        self.isFirst = isFirst
        self.isHidden = isHidden
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    mutating func setTHNation() {
        nationalityCode = "THA" //"🇹🇭 Thailand"
    }
    
    mutating func setUSNation() {
        nationalityCode = "USA" //"🇺🇸 United States"
    }
    
}

// encode & decode
extension Guest {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            
        self.id = try container.decode(Int.self, forKey: .id)
        self.nationalityCode = try container.decode(String.self, forKey: .nationalityCode)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.hotelID = try container.decode(Int.self, forKey: .hotelID)
                
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self,
                                         forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self,
                                         forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        
        self.firstName = (try? container.decode(String.self, forKey: .firstName)) ?? ""
        self.midName = (try? container.decode(String.self, forKey: .midName)) ?? ""
        self.lastName = (try? container.decode(String.self, forKey: .lastName)) ?? ""
        self.nickName = (try? container.decode(String.self, forKey: .nickName)) ?? ""
        self.citizenCardID = (try? container.decode(String.self, forKey: .citizenCardID)) ?? ""
        self.passportNo = (try? container.decode(String.self, forKey: .passportNo)) ?? ""
                
        self.titleCode = (try? container.decode(String.self, forKey: .title))
                
        self.birthdate = try? container.decode(String.self, forKey: .birthdate).tryToDate(FormConfig.DateFormat.yyyyMMdd)
        self.gender = (try? container.decode(Gender.self, forKey: .gender)) ?? Gender.unknow
        
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.phone = (try? container.decode(String.self, forKey: .phone)) ?? ""
        
        // address
        let _houseNumber = (try? container.decode(String.self, forKey: .address)) ?? ""
        let _district = (try? container.decode(String.self, forKey: .district)) ?? ""
        let _province = (try? container.decode(String.self, forKey: .province)) ?? ""
        let _zipCode = (try? container.decode(String.self, forKey: .zipCode)) ?? ""
        self.address = Address(houseNumber: _houseNumber,
                               district: _district,
                               province: _province,
                               zipCode: _zipCode,
                               countryCode: countryCode)

        self.occupation = (try? container.decode(String.self, forKey: .occupation)) ?? ""
        self.note = (try? container.decode(String.self, forKey: .note)) ?? ""
        
        self.companyID = try? container.decode(Int.self, forKey: .companyID)
        self.isFirst = (try? container.decode(Bool.self, forKey: .isFirst)) ?? false
        self.isHidden = (try? container.decode(Bool.self, forKey: .isHidden)) ?? false
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(titleCode, forKey: .title)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(midName, forKey: .midName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(nickName, forKey: .nickName)
        
        try container.encode(nationalityCode, forKey: .nationalityCode)
        try container.encode(countryCode, forKey: .countryCode)
        
        if let safeBirthdate = birthdate {
            let _birthDate = safeBirthdate.toDateString(FormConfig.DateFormat.yyyyMMdd)
            try container.encode(_birthDate, forKey: .birthdate)
        } else {
            try container.encodeNil(forKey: .birthdate)
        }
        
        try container.encode(citizenCardID, forKey: .citizenCardID)
        try container.encode(passportNo, forKey: .passportNo)
        try container.encode(gender.rawValue, forKey: .gender)
        
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
                
        try container.encode(address.houseNumber, forKey: .address)
        try container.encode(address.district, forKey: .district)
        try container.encode(address.province, forKey: .province)
        try container.encode(address.zipCode, forKey: .zipCode)
        
        try container.encode(occupation, forKey: .occupation)
        try container.encode(note, forKey: .note)
        
        try container.encode(hotelID, forKey: .hotelID)
        try container.encode(companyID, forKey: .companyID)
        
        try container.encode(isHidden, forKey: .isHidden)        
        try container.encode(isFirst, forKey: .isFirst)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat),
                             forKey: .updatedAt)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case firstName = "first_name"
        case midName = "middle_name"
        case lastName = "last_name"
        case nickName = "nickname"
        case nationalityCode = "nationality"
        case countryCode = "country"
        case birthdate = "date_of_birth"
        case citizenCardID = "id_card_no"
        case passportNo = "passport_no"
        case gender
        case occupation
        case email
        case phone
        case address
        case district
        case province
        case zipCode = "zip_code"
        case note
        case hotelID = "hotel_id"
        case companyID = "company_id"
        case isFirst = "first_guest"
        case isHidden = "hidden"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
}

/*
 {
 "id": 290,
 "title": "Mr",
 "first_name": "John",
 "middle_name": "Mid",
 "last_name": "Doe",
 "nationality": "THA",
 "date_of_birth": "2022-11-20",
 "id_card_no": "1234567890123",
 "passport_no": null,
 "gender": "Female",
 "occupation": null,
 "email": "ab@email.com",
 "phone": "123123123",
 "address": "Dress test ",
 "district": "Bang Phli",
 "province": "Samut Prakan",
 "country": "THA",
 "zip_code": "10540",
 "note": "Asdasd",
 "nickname": "",
 "photos": [],
 "document_photos": [],
 "hidden": false,
 "created_at": "2022-11-21T21:40:42.072+07:00",
 "updated_at": "2022-11-21T21:40:42.072+07:00",
 "hotel_id": 105,
 "company_id": null,
 "images": []
 }
 */
    
extension Guest {
    
    enum Gender: String, Codable {
        case male = "male"
        case female = "female"
        case unknow = ""
        
        // need to support localize
        var title: String {
            switch self {
            case .male:
                return "Male"
                
            case .female:
                return "Female"
                
            default:
                return ""
            }
        }
        
        var logoImageName: String? {
            switch self {
            case .male:
                return "icon-customer-male"
                
            case .female:
                return "icon-customer-female"
                
            default:
                return nil
            }
        }
        
        var logoImage: UIImage? {
            switch self {
            case .male:
                return UIImage(named: "icon-customer-male")
                
            case .female:
                return UIImage(named: "icon-customer-female")
                
            default:
                return nil
            }
        }
        
    }
    
}
