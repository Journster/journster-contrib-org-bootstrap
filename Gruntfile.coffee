module.exports = (grunt) ->

  grunt.initConfig

    less:
      bootstrap:
        options:
          paths: 'bower_components/bootstrap/less'
        files: '.tmp/bootstrap.css': 'less/bootstrap.less'
      main:
        files: '.tmp/main.css': 'less/main.less'

    cssmin:
      combine:
        options:
          keepSpecialComments: 0
        files:
          'dist/lib/the.css': [
            '.tmp/bootstrap.css'
            '.tmp/main.css'
          ]

    copy:
      bootstrap:
        cwd: 'bower_components/bootstrap/dist/fonts/'
        src: '*'
        dest: 'dist/fonts/'
        expand: true
        filter: 'isFile'
      images:
        cwd: 'images/'
        src: '*'
        dest: 'dist/images/'
        expand: true
        filter: 'isFile'

    assemble:
      options: 
        flatten: true
        layoutdir: 'layouts'
        layout: 'default.hbs'
        partials: ['partials/*.hbs']
        assets: 'dist/images'
        data: ['package.json', 'data/*.json']
      pages:
        files:
          'dist/': ['content/*.hbs']
        
  grunt.registerTask 'default', ['assemble', 'style', 'copy']
  grunt.registerTask 'style', ['less', 'cssmin']

  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'assemble'
