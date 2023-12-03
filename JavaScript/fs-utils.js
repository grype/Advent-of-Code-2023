const fs = require('fs');
const path = require('path');

function findFile(dir, targetFile) {
    let files = fs.readdirSync(dir);
    let directories = [];

    for (let file of files) {
        let filePath = path.join(dir, file);
        let stats = fs.statSync(filePath);

        if (stats.isDirectory()) {
            directories.push(filePath);
        } else if (file === targetFile) {
            return filePath;
        }
    }

    for (let directory of directories) {
        let result = findFile(directory, targetFile);
        if (result) return result;
    }

    return null;
}

function findResourceFile(name) {
    return findFile(path.join(__dirname, '..'), name);
}

module.exports = {findResourceFile};