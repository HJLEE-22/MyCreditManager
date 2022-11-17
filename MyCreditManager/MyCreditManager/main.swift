//
//  main.swift
//  MyCreditManager
//
//  Created by 이형주 on 2022/11/16.
//

import Foundation

var studentsArray: [[String]] = []
var studentDic: [String:String] = [:]
var studentInfoArray: [String] = []

func checkInput() {
    print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    var input = readLine()
    if let input = input, let intInput = Int(input) {
            if 1...5 ~= intInput {
                print("DEBUG: input from data biding", intInput)
                switch intInput {
                case 1:
                    addingStudent()
                case 2:
                    deletingStudent()
//                case 3:
//                case 4:
//                case 5:
                default:
                    break
                }
                
            } else {
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
                checkInput()
                
            }

    } else if let input = input, input.lowercased() == "x" {
            print("프로그램을 종료합니다...")
    } else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
        checkInput()
    }
}

func addingStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    var nameInput = readLine()
    if let nameInput = nameInput, studentsArray.contains(where: { $0[0] == nameInput }) {
        print("\(nameInput)은 이미 존재하는 이름입니다. 추가하지 않습니다.")
        checkInput()
    } else if let nameInput = nameInput, nameInput.trimmingCharacters(in: .whitespaces) != "" {
        studentInfoArray.append(nameInput)
        studentsArray.append(studentInfoArray)
        studentInfoArray.removeAll()
        print("DEBUG: studentsArray", studentsArray)
        print("\(nameInput) 학생을 추가했습니다.")
        checkInput()
    } else if let nameInput = nameInput, nameInput.trimmingCharacters(in: .whitespaces) == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        checkInput()
    }
}

func deletingStudent() {
    var nameInput = readLine()
    print("삭제할 학생의 이름을 입력해주세요")
    if let nameInput = nameInput {
        print("DEBUG: studentsArray", studentsArray)
        if studentsArray.contains(where: { $0[0] == nameInput  }) {
            var studentIndexInArray = studentsArray.firstIndex(where: { $0[0] == nameInput })!
            studentsArray.remove(at: studentIndexInArray)
            print("\(nameInput)학생을 삭제하였습니다.")
            print("DEBUG: studentsArray", studentsArray)
            checkInput()
        } else {
            print("\(nameInput) 학생을 찾지 못했습니다.")
            print("DEBUG: studentsArray", studentsArray)
            checkInput()
        }
    }
}

checkInput()

