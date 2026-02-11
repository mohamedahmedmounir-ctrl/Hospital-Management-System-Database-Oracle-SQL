-- ------------------- CREATE TABLES -------------------

CREATE TABLE Patient (
    PatientID      NUMBER(10)     PRIMARY KEY,
    FirstName      VARCHAR2(50)   NOT NULL,
    LastName       VARCHAR2(50)   NOT NULL,
    Gender         VARCHAR2(10),
    DateOfBirth    DATE,
    Address        VARCHAR2(200),
    ContactNumber  VARCHAR2(20),
    Insurance      VARCHAR2(50)
);

CREATE TABLE Department (
    DepartmentID    NUMBER(10)     PRIMARY KEY,
    DepartmentName  VARCHAR2(100)  NOT NULL,
    Location        VARCHAR2(100)
);

CREATE TABLE Ward (
    WardID      NUMBER(10)     PRIMARY KEY,
    WardName    VARCHAR2(100)  NOT NULL,
    Type        VARCHAR2(50)
);

CREATE TABLE Room (
    RoomID           NUMBER(10)    PRIMARY KEY,
    RoomNumber       VARCHAR2(10)  NOT NULL,
    Type             VARCHAR2(50),
    AvailabilityStatus VARCHAR2(20),
    WardID_FK        NUMBER(10)    NOT NULL,
    CONSTRAINT fk_room_ward
        FOREIGN KEY (WardID_FK) REFERENCES Ward(WardID)
);

CREATE TABLE Staff (
    StaffID         NUMBER(10)     PRIMARY KEY,
    FirstName       VARCHAR2(50)   NOT NULL,
    LastName        VARCHAR2(50)   NOT NULL,
    Gender          VARCHAR2(10),
    Role            VARCHAR2(50),
    Specialisation  VARCHAR2(100),
    ContactNumber   VARCHAR2(20),
    DepartmentID_FK NUMBER(10)     NOT NULL,
    CONSTRAINT fk_staff_department
        FOREIGN KEY (DepartmentID_FK) REFERENCES Department(DepartmentID)
);

CREATE TABLE Admission (
    AdmissionID     NUMBER(10)    PRIMARY KEY,
    AdmissionDate   DATE          NOT NULL,
    LeaveDate       DATE,
    PatientID_FK    NUMBER(10)    NOT NULL,
    StaffID_FK      NUMBER(10)    NOT NULL,
    RoomID_FK       NUMBER(10)    NOT NULL,
    CONSTRAINT fk_admission_patient
        FOREIGN KEY (PatientID_FK) REFERENCES Patient(PatientID),
    CONSTRAINT fk_admission_staff
        FOREIGN KEY (StaffID_FK) REFERENCES Staff(StaffID),
    CONSTRAINT fk_admission_room
        FOREIGN KEY (RoomID_FK) REFERENCES Room(RoomID)
);

CREATE TABLE Test (
    TestID       NUMBER(10)     PRIMARY KEY,
    TestName     VARCHAR2(100)  NOT NULL,
    Description  VARCHAR2(255),
    Cost         NUMBER(10,2)
);

CREATE TABLE Treatment (
    TreatmentID     NUMBER(10)     PRIMARY KEY,
    TreatmentName   VARCHAR2(100)  NOT NULL,
    Description     VARCHAR2(255),
    Cost            NUMBER(10,2)
);

CREATE TABLE Invoice (
    InvoiceID       NUMBER(10)     PRIMARY KEY,
    AdmissionID_FK  NUMBER(10)     NOT NULL,
    TotalCost       NUMBER(10,2),
    PaymentStatus   VARCHAR2(20),
    CONSTRAINT fk_invoice_admission
        FOREIGN KEY (AdmissionID_FK) REFERENCES Admission(AdmissionID)
);

-- ------------------- INSERTS -------------------

-- 1) Patient
INSERT INTO Patient VALUES (1,'Ahmed','Ali','Male',TO_DATE('1990-01-01','YYYY-MM-DD'),'Cairo','01000000001','Aetna');
INSERT INTO Patient VALUES (2,'Mona','Hassan','Female',TO_DATE('1985-02-14','YYYY-MM-DD'),'Giza','01000000002','Bupa');
INSERT INTO Patient VALUES (3,'Omar','Khaled','Male',TO_DATE('2000-06-20','YYYY-MM-DD'),'Alex','01000000003','MetLife');
INSERT INTO Patient VALUES (4,'Sara','Nasser','Female',TO_DATE('1995-09-09','YYYY-MM-DD'),'Cairo','01000000004','Aetna');
INSERT INTO Patient VALUES (5,'Tamer','Fahmy','Male',TO_DATE('1988-12-12','YYYY-MM-DD'),'Giza','01000000005','Bupa');
INSERT INTO Patient VALUES (6,'Hana','Youssef','Female',TO_DATE('2002-03-03','YYYY-MM-DD'),'Alex','01000000006','MetLife');
INSERT INTO Patient VALUES (7,'Mostafa','Ibrahim','Male',TO_DATE('1993-07-07','YYYY-MM-DD'),'Cairo','01000000007','Aetna');
INSERT INTO Patient VALUES (8,'Laila','Mahmoud','Female',TO_DATE('1999-11-11','YYYY-MM-DD'),'Giza','01000000008','Bupa');
INSERT INTO Patient VALUES (9,'Khaled','Sami','Male',TO_DATE('1991-05-05','YYYY-MM-DD'),'Alex','01000000009','MetLife');
INSERT INTO Patient VALUES (10,'Dina','Adel','Female',TO_DATE('1996-04-04','YYYY-MM-DD'),'Cairo','01000000010','Aetna');

-- 2) Department
INSERT INTO Department VALUES (1,'Cardiology','Building A');
INSERT INTO Department VALUES (2,'Neurology','Building B');
INSERT INTO Department VALUES (3,'Orthopedics','Building C');
INSERT INTO Department VALUES (4,'Pediatrics','Building A');
INSERT INTO Department VALUES (5,'Radiology','Building B');
INSERT INTO Department VALUES (6,'Oncology','Building C');
INSERT INTO Department VALUES (7,'Dermatology','Building A');
INSERT INTO Department VALUES (8,'Gastroenterology','Building B');
INSERT INTO Department VALUES (9,'Psychiatry','Building C');
INSERT INTO Department VALUES (10,'Urology','Building A');

-- 3) Ward
INSERT INTO Ward VALUES (1,'Cardio Ward','General');
INSERT INTO Ward VALUES (2,'Neuro Ward','ICU');
INSERT INTO Ward VALUES (3,'Ortho Ward','General');
INSERT INTO Ward VALUES (4,'Pediatrics Ward','Pediatrics');
INSERT INTO Ward VALUES (5,'Radiology Ward','Imaging');
INSERT INTO Ward VALUES (6,'Oncology Ward','General');
INSERT INTO Ward VALUES (7,'Derm Ward','General');
INSERT INTO Ward VALUES (8,'Gastro Ward','General');
INSERT INTO Ward VALUES (9,'Psych Ward','Psychiatric');
INSERT INTO Ward VALUES (10,'Urology Ward','General');

-- 4) Room
INSERT INTO Room VALUES (1,'101','Single','Available',1);
INSERT INTO Room VALUES (2,'102','Double','Occupied',1);
INSERT INTO Room VALUES (3,'201','Single','Available',2);
INSERT INTO Room VALUES (4,'202','Double','Available',2);
INSERT INTO Room VALUES (5,'301','Single','Occupied',3);
INSERT INTO Room VALUES (6,'302','Double','Available',3);
INSERT INTO Room VALUES (7,'401','Single','Available',4);
INSERT INTO Room VALUES (8,'402','Double','Occupied',4);
INSERT INTO Room VALUES (9,'501','Single','Available',5);
INSERT INTO Room VALUES (10,'502','Double','Occupied',5);

-- 5) Staff
INSERT INTO Staff VALUES (1,'Ali','Hassan','Male','Doctor','Cardiologist','0110000001',1);
INSERT INTO Staff VALUES (2,'Sara','Omar','Female','Nurse','ICU','0110000002',2);
INSERT INTO Staff VALUES (3,'Omar','Fahmy','Male','Doctor','Orthopedic','0110000003',3);
INSERT INTO Staff VALUES (4,'Mona','Khaled','Female','Nurse','Pediatrics','0110000004',4);
INSERT INTO Staff VALUES (5,'Tamer','Adel','Male','Doctor','Radiologist','0110000005',5);
INSERT INTO Staff VALUES (6,'Hana','Mahmoud','Female','Nurse','Oncology','0110000006',6);
INSERT INTO Staff VALUES (7,'Mostafa','Sami','Male','Doctor','Dermatologist','0110000007',7);
INSERT INTO Staff VALUES (8,'Laila','Nasser','Female','Nurse','Gastroenterology','0110000008',8);
INSERT INTO Staff VALUES (9,'Khaled','Ibrahim','Male','Doctor','Psychiatrist','0110000009',9);
INSERT INTO Staff VALUES (10,'Dina','Youssef','Female','Nurse','Urology','0110000010',10);

-- 6) Admission
INSERT INTO Admission VALUES (1,TO_DATE('2025-01-01','YYYY-MM-DD'),NULL,1,1,1);
INSERT INTO Admission VALUES (2,TO_DATE('2025-01-05','YYYY-MM-DD'),NULL,2,2,2);
INSERT INTO Admission VALUES (3,TO_DATE('2025-01-10','YYYY-MM-DD'),NULL,3,3,3);
INSERT INTO Admission VALUES (4,TO_DATE('2025-01-15','YYYY-MM-DD'),NULL,4,4,4);
INSERT INTO Admission VALUES (5,TO_DATE('2025-01-20','YYYY-MM-DD'),NULL,5,5,5);
INSERT INTO Admission VALUES (6,TO_DATE('2025-01-25','YYYY-MM-DD'),NULL,6,6,6);
INSERT INTO Admission VALUES (7,TO_DATE('2025-01-30','YYYY-MM-DD'),NULL,7,7,7);
INSERT INTO Admission VALUES (8,TO_DATE('2025-02-04','YYYY-MM-DD'),NULL,8,8,8);
INSERT INTO Admission VALUES (9,TO_DATE('2025-02-09','YYYY-MM-DD'),NULL,9,9,9);
INSERT INTO Admission VALUES (10,TO_DATE('2025-02-14','YYYY-MM-DD'),NULL,10,10,10);

-- 7) Test
INSERT INTO Test VALUES (1,'Blood Test','Routine blood analysis',50);
INSERT INTO Test VALUES (2,'X-Ray','Chest X-ray',100);
INSERT INTO Test VALUES (3,'MRI','Brain MRI',800);
INSERT INTO Test VALUES (4,'CT Scan','Abdominal CT scan',600);
INSERT INTO Test VALUES (5,'Urine Test','Routine urine analysis',30);
INSERT INTO Test VALUES (6,'ECG','Heart ECG',120);
INSERT INTO Test VALUES (7,'EEG','Brain EEG',200);
INSERT INTO Test VALUES (8,'Ultrasound','Abdominal Ultrasound',150);
INSERT INTO Test VALUES (9,'Biopsy','Tissue biopsy',500);
INSERT INTO Test VALUES (10,'COVID Test','PCR Test',70);

-- 8) Treatment
INSERT INTO Treatment VALUES (1,'Physiotherapy','Muscle therapy',200);
INSERT INTO Treatment VALUES (2,'Chemotherapy','Cancer treatment',1000);
INSERT INTO Treatment VALUES (3,'Surgery','Appendix removal',1500);
INSERT INTO Treatment VALUES (4,'Dialysis','Kidney dialysis',800);
INSERT INTO Treatment VALUES (5,'Vaccination','Flu vaccine',50);
INSERT INTO Treatment VALUES (6,'Stent','Heart stent placement',2000);
INSERT INTO Treatment VALUES (7,'Wound Dressing','Minor wound care',100);
INSERT INTO Treatment VALUES (8,'Blood Transfusion','Blood replacement',300);
INSERT INTO Treatment VALUES (9,'Physiotherapy','Rehab exercise',180);
INSERT INTO Treatment VALUES (10,'Endoscopy','Gastrointestinal endoscopy',400);

-- 9) Invoice
INSERT INTO Invoice VALUES (1,1,1500,'Paid');
INSERT INTO Invoice VALUES (2,2,2000,'Unpaid');
INSERT INTO Invoice VALUES (3,3,1800,'Paid');
INSERT INTO Invoice VALUES (4,4,2200,'Paid');
INSERT INTO Invoice VALUES (5,5,900,'Unpaid');
INSERT INTO Invoice VALUES (6,6,3000,'Paid');
INSERT INTO Invoice VALUES (7,7,1000,'Unpaid');
INSERT INTO Invoice VALUES (8,8,1200,'Paid');
INSERT INTO Invoice VALUES (9,9,800,'Unpaid');
INSERT INTO Invoice VALUES (10,10,400,'Paid');

-- ------------------- QUERIES -------------------

-- 1) Get all female patients
SELECT FirstName, LastName
FROM Patient
WHERE Gender = 'Female';

-- 2) List all departments located in Building A
SELECT DepartmentName
FROM Department
WHERE Location = 'Building A';

-- 3) Show all available rooms
SELECT RoomNumber, Type
FROM Room
WHERE AvailabilityStatus = 'Available';

-- 4) Count how many doctors and nurses exist
SELECT Role, COUNT(*) AS TotalStaff
FROM Staff
GROUP BY Role;

-- 5) Show admissions with patient names
SELECT A.AdmissionID, P.FirstName, P.LastName, A.AdmissionDate
FROM Admission A
JOIN Patient P ON A.PatientID_FK = P.PatientID;

-- 6) Show staff with their department
SELECT S.FirstName, S.LastName, S.Role, D.DepartmentName
FROM Staff S
JOIN Department D ON S.DepartmentID_FK = D.DepartmentID;

-- 7) List all rooms with their ward name
SELECT R.RoomNumber, R.Type, W.WardName
FROM Room R
JOIN Ward W ON R.WardID_FK = W.WardID;

-- 8) Show patient admissions with the room type
SELECT P.FirstName, P.LastName, R.Type AS RoomType
FROM Admission A
JOIN Patient P ON A.PatientID_FK = P.PatientID
JOIN Room R ON A.RoomID_FK = R.RoomID;

-- 9) List invoices with the patient name and amount
SELECT I.InvoiceID, I.TotalCost, I.PaymentStatus, P.FirstName, P.LastName
FROM Invoice I
JOIN Admission A ON I.AdmissionID_FK = A.AdmissionID
JOIN Patient P ON A.PatientID_FK = P.PatientID;

-- 10) Count rooms in each ward
SELECT W.WardName, COUNT(R.RoomID) AS RoomCount
FROM Ward W
LEFT JOIN Room R ON W.WardID = R.WardID_FK
GROUP BY W.WardName;


