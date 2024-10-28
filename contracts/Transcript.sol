// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transcript {
    struct Student {
        string name;
        string studentId;
        string course;
        string graduationYear;
        bool isVerified;
    }

    address public owner;
    mapping(string => Student) private students;

    event TranscriptIssued(string studentId, string name, string course, string graduationYear);
    event TranscriptVerified(string studentId, bool isVerified);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }

    function issueTranscript(
        string memory _name,
        string memory _studentId,
        string memory _course,
        string memory _graduationYear
    ) public onlyOwner {
        require(bytes(_studentId).length > 0, "Student ID cannot be empty.");
        require(!students[_studentId].isVerified, "Transcript already issued for this student.");

        students[_studentId] = Student(_name, _studentId, _course, _graduationYear, false);
        emit TranscriptIssued(_studentId, _name, _course, _graduationYear);
    }

    function verifyTranscript(string memory _studentId) public onlyOwner {
        require(students[_studentId].isVerified == false, "Transcript is already verified.");
        students[_studentId].isVerified = true;

        emit TranscriptVerified(_studentId, true);
    }

    function getTranscript(string memory _studentId) public view returns (string memory, string memory, string memory, string memory, bool) {
        require(bytes(students[_studentId].studentId).length > 0, "Transcript not found.");
        
        Student memory s = students[_studentId];
        return (s.name, s.studentId, s.course, s.graduationYear, s.isVerified);
    }
}
