//
//  StudentService.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import Foundation

final class StuentService {
    let json = """
    [
        {"name": "An", "age": 20},
        {"name": "Bình", "age": 22},
        {"name": "Chi", "age": 21}
    ]
    """
    
//MARK: fetch student list delegate
    func fetchStudentDelegate() -> [Student]? {
        let data = Data(json.utf8)
        
        do {
            let students = try JSONDecoder().decode([Student].self, from: data)
            return students
        } catch(let error) {
            debugPrint("Error: \(error)")
            return nil
        }
    }
    
//MARK: fetch student list closure call back
    func fetchStudentClosureCallBack(completion: @escaping (Result<[Student], Error>) -> Void) {
        let data = Data(json.utf8)
        
        do {
        
        } catch (let error) {
            debugPrint("Error: \(error)")
        }
    }
}
