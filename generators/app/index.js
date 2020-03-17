var Generator = require('yeoman-generator');

module.exports = class extends Generator {
    constructor(args, opts) {
        super(args, opts);
    
        // this.option('babel'); // This method adds support for a `--babel` flag
      }

      async prompting() {
        this.answers = await this.prompt([
          {
            type: "input",
            name: "name",
            message: "Your project name",
            default: this.appname // Default to current folder name
          }
        ]);
      }

      configuring() {
          this.config.set('applicationName', this.answers.name);
      }

      writing() {
        const rootFiles = [ 
            'debug.pl',
            'dev.settings.pl',
            'Dockerfile',
            'load.pl',
            'run.pl' ,
            'server.pl',
            'start.pl'
        ];

        rootFiles.map( template => 
        this.fs.copyTpl(
            this.templatePath(template),
            this.destinationPath(template),
            { 'applicationName': this.answers.name }
        ));

        const sourceFiles = [ 
            'main.pl',
            'routing.pl'
        ];

        sourceFiles.map( source => 
        this.fs.copyTpl(
            this.templatePath(source),
            this.destinationPath('sources/' + source),
            { 'applicationName': this.answers.name }
        ));

        const assetFiles = [ 
            'favicon.ico'
        ];
        assetFiles.map( asset => 
        this.fs.copy(
            this.templatePath('assets/' + asset),
            this.destinationPath('assets/' + asset)
        ));
      }
};