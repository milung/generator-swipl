'use strict';
const Generator = require('yeoman-generator');
const path = require('path');

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    this.argument("moduleName", { type: String, required: true, desc: 'name of the module' });    
  } 
  
  writing() {        

    var relativePath = '';
    if ( this.destinationPath('sources') !== this.contextRoot &&  this.destinationPath() !== this.contextRoot ) {
      relativePath = path.relative(this.destinationPath('sources'), this.contextRoot) + '/';
    }
    
    const sourceFiles = [ 
        'module.pl'
    ];

    sourceFiles.map( source => 
    this.fs.copyTpl(
        this.templatePath(source),
        this.destinationPath('sources/' + relativePath + this.options.moduleName + '.pl'),
        { 'moduleName': this.options.moduleName }
    ));


    const loader = this.fs.read(this.destinationPath('load.pl'));
    const regex = /:-\ *use_module\(.*\)\./g;
    var result = regex.exec(loader);
    var index = 0;
   
    while(result) {
      index = regex.lastIndex;
      result = regex.exec(loader);
    }    
    
    if(index) {
        const update 
            = loader.substring(0, index)
            + '\r\n:- use_module(source(' + relativePath + this.options.moduleName + ')).'
            + loader.substring(index);

        this.fs.write(this.destinationPath('load.pl'), update);
    }

  }

  
};
