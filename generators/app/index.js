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
            message: "Name of docker image and of CLI command to execute your program",
            default: this.appname // Default to current folder name
          },
          {
            type: "input",
            name: "registry",
            message: "Docker registry for the generated image",
            store: true
          }
        ]);
      }

      configuring() {
          this.config.set('applicationName', this.answers.name);
          this.config.set('commandName', this.answers.command);
          this.config.set('registry', this.answers.registry);
      }

      writing() {
        const rootFiles = [ 
            'azure-pipelines.yml',
            'debug.pl',
            'README.md',
            'Dockerfile',
            "init.pl",
            'load.pl',
            'packages.pl',
            'run.pl' ,
            
            'link.pl',
            'docker-build.ps1'
        ];

        rootFiles.map( template => 
        this.fs.copyTpl(
            this.templatePath(template),
            this.destinationPath(template),
            { 
              'applicationName': this.answers.name,
              'commandName': this.answers.command,
              'registry': this.answers.registry
            }
        ));

        this.fs.copyTpl(
          this.templatePath('command.ps1'),
          this.destinationPath(this.answers.command + '.ps1'),
          { 
            'applicationName': this.answers.name,
            'commandName': this.answers.command,
            'registry': this.answers.registry
          });

        const sourceFiles = [ 
            'routing.pl',
            'server.pl',
            'api/api.pl',
            'api/api.plt'
        ];

        sourceFiles.map( source => 
        this.fs.copyTpl(
            this.templatePath(source),
            this.destinationPath('sources/' + source),
            { 'applicationName': this.answers.name }
        ));

        const assetFiles = [ 
            'favicon.ico',
            'openapi.yaml'
        ];
        assetFiles.map( asset => 
        this.fs.copy(
            this.templatePath('assets/' + asset),
            this.destinationPath('assets/' + asset)
        ));

        const configFiles = [ 
          'config.env',
          'config.user.env'
      ];
      configFiles.map( asset => 
      this.fs.copy(
          this.templatePath('config/' + asset),
          this.destinationPath('config/' + asset)
      ));
      }
};