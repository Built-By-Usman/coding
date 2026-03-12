//Arrays
// let array = ["Apple", "Mango", "Banana"];

// console.log(array);
// console.log(array[1]);
// array.push("Orange");
// console.log(array)

//task


let marks = [20, 30, 40, 50, 60];
let sum = 0;

for (let i = 0; i < marks.length; i++) {
    console.log(marks[i]);
    sum += marks[i];
}

let average = sum / marks.length;


console.log("Sum is " + sum);
console.log("Average " + average);

marks.push(90);

console.log("New List");

console.log(marks);