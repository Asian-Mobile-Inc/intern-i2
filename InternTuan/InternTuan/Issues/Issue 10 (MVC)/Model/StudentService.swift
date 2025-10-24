//
//  StudentService.swift
//  InternTuan
//
//  Created by Nguên Bản on 20/10/25.
//

import Foundation
import Combine

protocol Issue10ViewControllefDelegate: AnyObject {
    func didFetchStudent(students: [Student])
}

enum StatusAction {
    case succ
    case fail
}
 
final class StudentService {
    weak var issue10VCDlg: Issue10ViewControllefDelegate?
    
    @Published var onChange: String = ""
    
    var action = PassthroughSubject<StatusAction, Never>()
    
    let json = """
    [
        {"name": "An", "age": 20},
        {"name": "Bình", "age": 22},
        {"name": "Chi", "age": 21}
    ]
    """
    
//MARK: fetch student list delegate
    func fetchStudentDelegate() {
        let data = Data(json.utf8)
        
        do {
            let students = try JSONDecoder().decode([Student].self, from: data)
            debugPrint("call issue 10 VC delegate (model -> controllef)")
            self.issue10VCDlg?.didFetchStudent(students: students)
        } catch(let error) {
            debugPrint("Error: \(error)")
        }
    }
    
//MARK: fetch student list closure call back
    func fetchStudentClosureCallBack(completion: @escaping (Result<[Student], Error>) -> Void) {
        let data = Data(json.utf8)
        
        do {
            let students = try JSONDecoder().decode([Student].self, from: data)
            debugPrint("call back from model (model -> controller)")
            completion(.success(students))
            action.send(.succ)
        } catch (let error) {
            completion(.failure(error))
        }
    }
    
//MARK: fetch student list notification
    func fetchStudentListNotification() {
        let data = Data(json.utf8)
        
        do {
            let students = try JSONDecoder().decode([Student].self, from: data)
            debugPrint("post notification (model -> controller)")
            NotificationCenter.default.post(
                name: .didFetchStudentList,
                object: nil,
                userInfo: [StringConstants.notification.userInfo.students : students]
            )
        } catch (let error) {
            debugPrint("error: \(error)")
        }
    }
}
