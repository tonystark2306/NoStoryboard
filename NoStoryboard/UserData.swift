// UserData.swift
import Foundation

struct UserData: Equatable {
    let id: UUID
    var firstName: String
    var lastName: String
    var weight: String
    var height: String
    var age: String
    var gender: String
    
    init(firstName: String, lastName: String, weight: String, height: String, age: String, gender: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
    }
    
    init(id: UUID, firstName: String, lastName: String, weight: String, height: String, age: String, gender: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.age = age
        self.gender = gender
    }
    
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        return lhs.id == rhs.id
    }
}
