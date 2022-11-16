//
//  main.swift
//  MyCreditManager
//
//  Created by 이형주 on 2022/11/16.
//

import Foundation

func checkInput() {
    print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    var input = readLine()
    if let input = input, let intInput = Int(input) {
            if 1...5 ~= intInput {
                print(intInput)

                
            } else {
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
                checkInput()
                
            }

    } else if let input = input {
        if input.lowercased() == "x" {
            print("프로그램을 종료합니다...")
        }
    } else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.");
        checkInput()
    }
}

checkInput()

