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
          },
          {
            type: "input",
            name: "command",
            message: "Name of CLI command to execute your program",
            default: this.appname // Default to current folder name
          }
        ]);
      }

      configuring() {
          this.config.set('applicationName', this.answers.name);
          this.config.set('commandName', this.answers.command);
      }

      writing() {
        const rootFiles = [ 
            'debug.pl',
            'dev.settings.pl',
            'Dockerfile',
            'load.pl',
            'run.pl' ,
            'server.pl',
            'start.pl',
            'docker-build.ps1'
        ];

        rootFiles.map( template => 
        this.fs.copyTpl(
            this.templatePath(template),
            this.destinationPath(template),
            { 
              'applicationName': this.answers.name,
              'commandName': this.answers.command
            }
        ));

        this.fs.copyTpl(
          this.templatePath('command.ps1'),
          this.destinationPath(his.answers.command + '.ps1'),
          { 
            'applicationName': this.answers.name,
            'commandName': this.answers.command
          });

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