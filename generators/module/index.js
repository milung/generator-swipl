'use strict';
const Generator = require('yeoman-generator');
const path = require('path');

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    this.argument("moduleName", { type: String, required: true, desc: 'name of the module' });   
    const destination = this.findDestinationParent(this.destinationRoot()) ;
    this.destinationRoot(destination);
    
  } 
  
  findDestinationParent(current) {
    const storage = path.join(current, '.yo-rc.json');
    if( this.fs.exists(storage)) return current;
    else {
      const parent =  path.dirname(current);
      if(parent == current) return this.contextRoot
      else return this.findDestinationParent(parent);
    }
  }
  
  writing() {        
    var relativePath = '';
    if ( this.destinationPath('sources') !== this.contextRoot &&  this.destinationPath() !== this.contextRoot ) {
      relativePath = path.relative(this.destinationPath('sources'), this.contextRoot) + '/';
    }
    const modulePath = relativePath + this.options.moduleName;
    const moduleFiles = [ 
        '.pl',
        '.plt'
    ];
    console.log("RELATIVE path: %s, module path: %s, destination: %s, ctx: %s ",
     relativePath,  this.findDestinationParent(this.destinationRoot()), this.destinationRoot(),this.contextRoot)

    moduleFiles.map( extension => 
      this.fs.copyTpl(
        this.templatePath('module' + extension),
        this.destinationPath('sources/' + modulePath + extension),
        { 'moduleName': this.options.moduleName, modulePath }
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
            + '\r\n:- use_module(source(' + modulePath + ')).'
            + loader.substring(index);

        this.fs.write(this.destinationPath('load.pl'), update);
    }

  }

  
};
