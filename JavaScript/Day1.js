const fs = require('fs');
require('./string-utils.js');
const {findResourceFile} = require('./fs-utils.js');
const readline = require('readline');
const {Readable} = require('stream');

const sample1 = `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet`;

const sample2 = `two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen`;

function getCalibrationValueUsingNumerics(str) {
    const matches = str.match(/\d/g);
    const numString = `${matches[0]}${matches[matches.length-1]}`;
    return Number(numString);
}

function getCalibrationValueUsingAlphaNumerics(str) {
    const decimalWords = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
    const patternString = `[0-9]|${decimalWords.join("|")}`; 
    const regex = RegExp(patternString, "g");
    let matches = str.match(regex);
    return [matches[0], matches[matches.length-1]].reduce((sum, match, matchIndex, array)=>{
        let wordIndex = decimalWords.indexOf(match);
        // if found, the wordIndex would equate to the represented numeric value
        // otherwised we matched a digit
        // the resulting numeric value is then multipled by 10^(length-index) - so first digit is 10s the second is 1s
        return sum + ((wordIndex < 0 ? Number(match) : wordIndex)) * Math.pow(10, array.length-(matchIndex + 1));
    }, 0);
}

function sumCalibrationValues(stream, fn) {
    return new Promise(resolve => {
        const rl = readline.createInterface({ input: stream });
        var sum = 0;
        rl.on('line', (line)=>{
            sum += fn(line);
        });
        rl.on('close', () => {
            resolve(sum);
            rl.close();
        });
    });
}

async function part1() {
    // const stream = sample1.createReadStream();
    const stream = fs.createReadStream(findResourceFile('day1.txt'));
    let result = await sumCalibrationValues(stream, getCalibrationValueUsingNumerics);
    console.log(`Part1: ${result}`);
}

async function part2() {
    // const stream = sample2.createReadStream();
    const stream = fs.createReadStream(findResourceFile('day1.txt'));
    let result = await sumCalibrationValues(stream, getCalibrationValueUsingAlphaNumerics);
    console.log(`Part1: ${result}`);
}

part1();
part2();