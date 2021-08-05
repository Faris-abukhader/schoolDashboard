//
//  data.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/21.
//

import Foundation
import SwiftUI
import CoreData
class data:ObservableObject {
    
    // sign in view
    @Published var page = 1
    @Published var username = ""
    @Published var password = ""
    @Published var shake = false
    
        
    @Published var width = UIScreen.main.bounds.width
    @Published var height = UIScreen.main.bounds.height
    @Published var mainViewWidth = UIScreen.main.bounds.width - UIScreen.main.bounds.width/5
    @Published var mainViewHeight = UIScreen.main.bounds.height - UIScreen.main.bounds.height/13
    @Published var show  = true
    @Published var pageIndex = 1
    @Published var showSignoutList = false
    
    
    // all teacher view
    @Published var showAddTeacherWindow = false
    @Published var teacherSearchContent = ""
    @Published var teacherStudentDetail = false
    @Published var TeacherDetail = Teacher()
    @Published var showTeacherEdit = false
    @Published var teacherSortType = 1
    @Published var showTeacherDetail = false
    @Published var showAddGradeToTeacher = false
    @Published var showChoosingTeacherForAddingGrade = false
    @Published var TeacherChosedForAddingGrade = ""
    @Published var showChoosingGrade = false
    @Published var showTeacherGradeEditWindow = false
    


    
    
    // all student view
    @Published var showAddStudentWindow = false
    @Published var studentSearchContent = ""
    @Published var showStudentDetail = false
    @Published var studentDetail = Student()
    @Published var showStudentEdit = false
    @Published var studentEdit = Student()
    @Published var studentSortType = 1
    
    
    // all parents
    @Published var parentSearchContent = ""
    @Published var showEditFather = false
    
    // all grades
    @Published var showAddGradeWindow = false
    @Published var showEditGradeWindow = false
    @Published var showMoveToNewGradeWindow = false
    @Published var gradesSearchContent = ""
    @Published var roomNo = 0
    @Published var className = ""
    @Published var showThisGradeStudent = ""
    @Published var showGradeStudent = ""
    @Published var studentNameMoveToNewGrade = ""
    @Published var currentGrade = ""
    @Published var newGrade = ""
    @Published var firstGradeFees = 1000
    @Published var secondGradeFees = 1200
    @Published var thirdGradeFees = 1400
    @Published var fourthGradeFees = 1600
    @Published var fifthGradeFees = 1800
    @Published var sixthGradeFees = 2000
    @Published var seventhGradeFees = 1200
    @Published var eighthGradeFees = 1300
    @Published var ninthGradeFees = 1400
    @Published var tenthGradeFees = 1500

    
    
    // notice
    @Published var showEditNoticeView = false
    @Published var editNoticeTitle = ""
    @Published var editNoticeContent = ""
    @Published var editNoticeDate = Date()
    @Published var noticeSearchContent  = ""
    
    
    @Published var showToast = false
    @Published var toastContent = ""
    
    // all fees
    @Published var fees:[Int] = [1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000]
    @Published var showStudentPayment = false
    @Published var paymentId = ""
    @Published var showAllPayment = false
    @Published var showAlert = false
    @Published var feeSortType = 1
    @Published var feeSearchContent = ""
    
    
    // worker
    @Published var ShowWorkerDetail = false
    @Published var workerDetail = Worker()
    @Published var workerSearchContent = ""
    @Published var showAddWorkerWindow = false
    @Published var showEditWorker = false
    @Published var allWorkerSortType = 1
    
    // attendance
    @Published var showAttendanceForGrade = ""
    @Published var showAttendanceDetailForSpacificStudent = false
    @Published var studentNameForShowingAttendance = ""
    @Published var studentGradeForShowingAttendance = ""
    
    
    
    // teacher Dashboard
    @Published var teacherSubpageIndex = 11
    @Published var showGradeInfoView = false
    @Published var gradeToShowInfo = ""
    @Published var showStudentInfoForTeacher = false
    @Published var showStudentList = false
    @Published var showStudentAttendanceDetail = false
    @Published var studentNameForAttendanceDetail = ""
    @Published var gradeForStudentForAttendanceDetail = ""
    @Published var showStudentAnalysis = false
    
    // teacher exam
    @Published var showCreatingExamPage = false
    @Published var examName = ""
    @Published var examGrade = ""
    @Published var showGradeList = false
    @Published var question = ""
    @Published var examId = UUID()
    @Published var showAnswerListQuestion = ""
    @Published var showPreviewPage = false
    @Published var showEditQuestionWindow = false
    @Published var questionData = Array<String>()
    @Published var questionDataId = UUID()
    @Published var previewExamId = UUID()
    @Published var showDateAlert = true
    @Published var showStudentExamMark = false
    @Published var showStudentListGrade = ""
    @Published var showStudentListExamID = UUID()
    @Published var showStudentAnswerForTeacher = false
    @Published var showStudentAnswerPreivewID = UUID()
    @Published var showStudentAnswerPreivewStudentName = ""

    
    // student Exam
    @Published var studentExamPreviewID = UUID()
    @Published var showStudentExamPreview = false
    @Published var totalCorrectAnswer:Int16 = 0
    @Published var studentAnswers = [Int:String]()

    

    
}
