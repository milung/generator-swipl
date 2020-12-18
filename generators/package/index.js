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
            name: "package",
            message: "SWIPL Package name",
            default: this.appname // Default to current folder name
          },
          {
            type: "input",
            name: "title",
            message: "Readable title of the package",
            default: ""
          },
          {
            type: "input",
            name: "author",
            message: "Author of the package",
            default: this.user.git.name,
            store: true
          },
          {
            type: "input",
            name: "email",
            message: "Author's email",
            default: this.user.git.email,
            store: true
          },
          {
            type: "input",
            name: "homepage",
            message: "Homepage"
          }
        ]);
      }

      configuring() {
          this.config.set('packageName', this.answers.package);
          this.config.set('packageTitle', this.answers.title);
          this.config.set('author', this.answers.author);
          this.config.set('email', this.answers.email);
          this.config.set('homepage', this.answers.homepage);
      }

      writing() {
        const rootFiles = [            
            'debug.pl',            
            'pack.pl',
            'README.md',                        
            'run-tests.ps1'
        ];

        rootFiles.map( template => 
        this.fs.copyTpl(
            this.templatePath(template),
            this.destinationPath(template),
            { 
              'packageName': this.answers.package,
              'packageTitle': this.answers.title,
              'author': this.answers.author,
              'email': this.answers.email,
              'homepage': this.answers.homepage
            }
        ));

        this.fs.copyTpl(
          this.templatePath('module.pl'),
          this.destinationPath('prolog/' + this.answers.package + '.pl'),
          { 
            'packageName': this.answers.package,
            'packageTitle': this.answers.title,
            'author': this.answers.author,
            'email': this.answers.email,
            'homepage': this.answers.homepage
          });

          this.fs.copyTpl(
            this.templatePath('module.plt'),
            this.destinationPath('tests/' + this.answers.package + '.plt'),
            { 
              'packageName': this.answers.package,
              'packageTitle': this.answers.title,
              'author': this.answers.author,
              'email': this.answers.email,
              'homepage': this.answers.homepage
            });
        
      }
};