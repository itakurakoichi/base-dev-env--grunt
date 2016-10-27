module.exports = (grunt) ->
	require('time-grunt') grunt
	require('jit-grunt') grunt

	grunt.initConfig
		# Path Setting
		path:
			src: 'src'
			dest: 'dest'
			hbs: '<%= path.src %>/hbs'
			scss: '<%= path.src %>/scss'
			css: '<%= path.dest %>/css'
		# connect local server
		connect:
			server:
				options:
					hostname: 'localhost'
					port: 7777
					base: 'dest/'
		# assemble setting
		assemble:
			task1:
				files: [
					expand: true
					cwd: '<%= path.hbs %>/'
					src: '**/*.hbs'
					dest: '<%= path.dest %>/demo/'
				]
		# css framework, compass
		compass:
			options:
				noLineComments: true
				debugInfo: false
				outputStyle: 'compressed'
				force: true
			top:
				options:
					sassDir: '<%= path.scss %>/top/'
					cssDir: '<%= path.css %>/top/'
			# hoge_page:
			# 	options:
			# 		sassDir: '<%= path.scss %>/hoge_page/'
			# 		cssDir: '<%= path.css %>/hoge_page/'
		# watch files, and excuse tasks
		watch:
			options:
				livereload: true
				spawn: false
			assemble:
				files: '<%= path.hbs %>/*.hbs'
				tasks: [
					'newer:assemble'
				]
			compass:
				files: '<%= path.scss %>/**/*.scss'
				tasks: [
					'compass'
				]

	##
	# 各タスク
	grunt.registerTask 'hello', ->
		grunt.log.writeln('hello task excuse...');

	grunt.registerTask 'task_assemble', [ 'assemble' ]
	grunt.registerTask 'task_compass', [ 'compass' ]

	grunt.registerTask 'dev', [
		'hello'
		'connect'
		'watch'
	]