'use strict';
const Generator = require('yeoman-generator');

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    this.argument("moduleName", { type: String, required: true, desc: 'name of the module' });
    // this.option('babel'); // This method adds support for a `--babel` flag
  } 
  
  writing() {        

    const sourceFiles = [ 
        'module.pl'
    ];

    sourceFiles.map( source => 
    this.fs.copyTpl(
        this.templatePath(source),
        this.destinationPath('sources/' + this.moduleName + '.pl'),
        { 'moduleName': this.moduleName }
    ));

    const loader = this.fs.read(this.destinationPath('load.pl'));
    const regex = new RegExp(":-\s*use_module\(.*\)\.", g);
    regex.exec(loader);
    const index = regex.lastIndex;
    var relativePath = path.posix.relativePath(this.destinationPath('sources'), this.contextRoot);
    if (index) {
        const update 
            = loader.substring(0, index)
            + "\r\n:- use_module(source(" + relativePath + "/" + this.moduleName + "))."
            + loader.substring(index);
        
        this.fs.write(this.destinationPath('load.pl'), update);
    }

  }

  
};
