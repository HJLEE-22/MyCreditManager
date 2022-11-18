//
//  main.swift
//  MyCreditManager
//
//  Created by 이형주 on 2022/11/16.
//

import Foundation

var studentsArray: [[String]] = []
var studentInfoArray: [String] = []

enum CreditPoints: String {
    case Aplus = "A+"
    case A = "A"
    case Bplus = "B+"
    case B = "B"
    case Cplus = "C+"
    case C = "C"
    case Dplus = "D+"
    case D = "D"
}
/*
func calculateCredits() {
//    switch CreditPoints.self {
//    case Aplus:
//        return 4.5
//    }
//
    //    case A = 4.0
    //    case Bplus = 3.5
    //    case B = 3.0
    //    case Cplus = 2.5
    //    case C = 2.0
    //    case Dplus = 1.5
    //    case D = 1.0
}
*/

func checkInput() {
    print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    var input = readLine()
    if let input = input, let intInput = Int(input) {
            if 1...5 ~= intInput {
                switch intInput {
                case 1:
                    addingStudent()
                case 2:
                    deletingStudent()
                case 3:
                    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
                    var creditInput = readLine()
                    if let creditInput = creditInput {
                        var splittedInputArray = creditInput.split { $0 == " " }
                        
                        if splittedInputArray.endIndex < 3 {
                            print("입력이 잘못되었습니다. 다시 확인해주세요.")
                            checkInput()
                        } else if CreditPoints(rawValue: String(splittedInputArray[2])) == nil{
                            print("점수 입력이 잘못되었습니다. 다시 확인해주세요.")
                            checkInput()
                        } else if !studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
                            print("\(splittedInputArray[0]) 학생을 찾지 못했습니다.")
                            checkInput()
                            // 정상 추가/변경되는 경우
                        } else if studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
                            if studentsArray.contains(where: { $0.endIndex == 1 }) {
                                // 성적이 아무것도 없을때
                                var studentIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0]  })!
                                studentsArray[studentIndex].append(String(splittedInputArray[1]))
                                studentsArray[studentIndex].append(String(splittedInputArray[2]))
                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가(변경) 되었습니다.")
//                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가 되었습니다.")
                                checkInput()
                            } else if studentsArray.contains(where: { $0[1] == splittedInputArray[1] }) {
                                // 같은 과목의 성적이 있을 떼
                                var studentAndSubjectIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0] && $0[1] == splittedInputArray[1]  })!
                                studentsArray[studentAndSubjectIndex].remove(at: 2)
                                studentsArray[studentAndSubjectIndex].append(String(splittedInputArray[2]))
                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 추가(변경) 되었습니다.")
//                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목이 \(splittedInputArray[2])로 변경 되었습니다.")
                                checkInput()
                            }
                        }
                    }
                case 4:
                    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
                    var creditInput = readLine()
                    if let creditInput = creditInput {
                        var splittedInputArray = creditInput.split { $0 == " " }
                        print("DEBUG: splittedInputArray :", splittedInputArray)
                        
                        if splittedInputArray.endIndex < 2 {
                            print("입력이 잘못되었습니다. 다시 확인해주세요.")
                            checkInput()
                        } else if !studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
                            print("\(splittedInputArray[0]) 학생의 해당 과목 점수를 찾지 못했습니다.")
                            checkInput()
                        } else if studentsArray.contains(where: { $0[0] == splittedInputArray[0] }) {
                            if studentsArray.contains(where: { $0[1] == splittedInputArray[1] }) {
                                var studentAndSubjectIndex = studentsArray.firstIndex(where: { $0[0] == splittedInputArray[0] && $0[1] == splittedInputArray[1]  })!
                                // 배열의 내용 뿐 아니라 데이터 공간까지 지워야 함. 안그러면 빈 배열이 남아 차후 오류...
                                studentsArray[studentAndSubjectIndex].removeAll()
                                studentsArray.removeAll(where: { $0.isEmpty })
                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 과목의 성적이 삭제 되었습니다.")
                                checkInput()
                            } else {
                                print("\(splittedInputArray[0]) 학생을 찾지 못했습니다.")
//                                print("\(splittedInputArray[0]) 학생의 \(splittedInputArray[1]) 성적을 찾지 못했습니다.")
                                checkInput()
                            }
                        }
                    }
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
    print(studentsArray)
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
    print("삭제할 학생의 이름을 입력해주세요")
    var nameInput = readLine()
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

