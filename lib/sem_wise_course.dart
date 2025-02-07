import 'course_model.dart';

var courses = <int, List<CourseDetails>>{
  65: [
    CourseDetails(
        courseTitle: "Introduction to Computing",
        courseCode: "CSE-1101",
        credit: 2.0),
    CourseDetails(
        courseTitle: "Introduction to Computing Sessional",
        courseCode: "CSE-1102",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Discrete Mathematics",
        courseCode: "CSE-1151",
        credit: 3.0),
    CourseDetails(courseTitle: "Calculus", courseCode: "MAT-1151", credit: 3.0),
    CourseDetails(
        courseTitle: "Basic English", courseCode: "GED-1131", credit: 3.0),
  ],
  64: [
    CourseDetails(
        courseTitle: "Structured Programming",
        courseCode: "CSE-1211",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Structured Programming Sessional",
        courseCode: "CSE-1212",
        credit: 1.5),
    CourseDetails(
        courseTitle:
            "Differential Equation, Laplace Transform and Fourier Analysis",
        courseCode: "MAT-1251",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Physics: Heat, Light and Sound",
        courseCode: "GED-1171",
        credit: 2.0),
    CourseDetails(
        courseTitle: "Physics Laboratory", courseCode: "PHY-1272", credit: 1.5),
    CourseDetails(
        courseTitle: "Electrical Circuits",
        courseCode: "EEE-1221",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Electrical Circuits Sessional",
        courseCode: "EEE-1222",
        credit: 1.5),
  ],
  63: [
    CourseDetails(
        courseTitle: "Data Structures", courseCode: "CSE-2111", credit: 3.0),
    CourseDetails(
        courseTitle: "Data Structures Sessional",
        courseCode: "CSE-2112",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Electronic Devices and Circuits",
        courseCode: "EEE-2121",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Electronic Devices and Circuits Sessional",
        courseCode: "EEE-2122",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Coordinate Geometry & Vector Analysis",
        courseCode: "MAT-2151",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Sustainable Development",
        courseCode: "GED-1261",
        credit: 3.0),
  ],
  62: [
    CourseDetails(
        courseTitle: "Computer Algorithms and Complexity",
        courseCode: "CSE-2211",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Computer Algorithms and Complexity Sessional",
        courseCode: "CSE-2212",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Complex Variable and Probability",
        courseCode: "MAT-2251",
        credit: 2.0),
    CourseDetails(
        courseTitle: "Digital Logic Design",
        courseCode: "CSE-2221",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Digital Logic Design Sessional",
        courseCode: "CSE-2222",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Professional Practices and Ethics",
        courseCode: "GED-4251",
        credit: 3.0),
  ],
  61: [
    CourseDetails(
        courseTitle: "Object Oriented Programming",
        courseCode: "CSE-3111",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Object Oriented Programming Sessional",
        courseCode: "CSE-3112",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Computer Architecture and Design",
        courseCode: "CSE-3121",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Database Management System",
        courseCode: "CSE-3113",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Database Management System Sessional",
        courseCode: "CSE-3114",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Principles of Accounting",
        courseCode: "GED-1291",
        credit: 3.0),
  ],
  60: [
    CourseDetails(
        courseTitle: "Smartphone Application Development",
        courseCode: "CSE-3212",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Software Engineering",
        courseCode: "CSE-3213",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Software Engineering Sessional",
        courseCode: "CSE-3214",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Computer Networks", courseCode: "CSE-3231", credit: 3.0),
    CourseDetails(
        courseTitle: "Computer Networks Sessional",
        courseCode: "CSE-3232",
        credit: 1.5),
    CourseDetails(
        courseTitle:
            "Microprocessor, Assembly Language and Computer Interfacing",
        courseCode: "CSE-3201",
        credit: 3.0),
    CourseDetails(
        courseTitle:
            "Microprocessor, Assembly Language and Computer Interfacing Sessional",
        courseCode: "CSE-3202",
        credit: 1.5),
  ],
  59: [
    CourseDetails(
        courseTitle: "Artificial Intelligence",
        courseCode: "CSE-4111",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Artificial Intelligence Sessional",
        courseCode: "CSE-4112",
        credit: 1.5),
    CourseDetails(
        courseTitle: "Compiler Design and Construction",
        courseCode: "CSE-4113",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Compiler Design and Construction Sessional",
        courseCode: "CSE-4114",
        credit: 1.0),
    CourseDetails(
        courseTitle: "Web Technologies", courseCode: "CSE-4116", credit: 2.0),
    CourseDetails(
        courseTitle: "Computer and Cyber Security",
        courseCode: "CSE-4161",
        credit: 3.0),
  ],
  58: [
    CourseDetails(
        courseTitle: "Computer Graphics", courseCode: "CSE-4113", credit: 3.0),
    CourseDetails(
        courseTitle: "Computer Graphics Sessional",
        courseCode: "CSE-4114",
        credit: 1.0),
    CourseDetails(
        courseTitle: "Artificial Intelligence",
        courseCode: "CSE-4119",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Project-II/Thesis (Part-I)",
        courseCode: "CSE-4800",
        credit: 1.0),
  ],
  57: [
    CourseDetails(
        courseTitle: "Computer Security and Cryptography",
        courseCode: "CSE-4315",
        credit: 3.0),
    CourseDetails(
        courseTitle: "Machine Learning", courseCode: "CSE-4233", credit: 2.0),
    CourseDetails(
        courseTitle: "Machine Learning Sessional",
        courseCode: "CSE-4234",
        credit: 1.0),
    CourseDetails(
        courseTitle: "Project-II/Thesis (Part-II)",
        courseCode: "CSE-4801",
        credit: 3.0),
  ],
};
