
function calculateSquare(num) {

    return num * num;

}
function findGrade(num) {
    let grade;
    if (num > 90 && num <= 100) {
        grade = 'A';
    }
    else if (num > 80 && num <= 90) {
        grade = 'B'

    }
    else if (num > 70 && num <= 80) {
        grade = 'C'

    }
    else if (num > 60 && num <= 70) {

        grade = 'D'
    }
    else {
        grade = 'F'
    }

    return grade
}

function generateTable(table) {
    for (let i = 1; i <= 10; i++) {
        console.log(table * i);
    }

}

console.log(calculateSquare(4));


console.log(findGrade(80));

generateTable(3);
