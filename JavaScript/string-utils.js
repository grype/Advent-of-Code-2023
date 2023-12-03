String.prototype.createReadStream = function() {
    let str = this;
    return new Readable({
        read() {
            this.push(`${str}`);
            this.push(null);
        }
    });
}