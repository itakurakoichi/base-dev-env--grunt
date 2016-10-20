module.exports = (grunt) ->
	require('time-grunt') grunt
	require('jit-grunt') grunt

	grunt.initConfig
		# Path Setting
		path:
			src: 'src'
			dest: 'dest'
			hbs: '<%= path.src %>/hbs'
		# connect local server
		connect:
			server:
				options:
					hostname: 'localhost'
					port: 7777
					base: 'dist/'
		# assemble setting
		assemble:
			task1:
				files: [
					expand: true
					cwd: '<%= path.hbs %>/'
					src: '**/*.hbs'
					dest: '<%= path.dest %>/demo/'
				]
		# watch files, and excuse tasks
		watch:
			options:
				livereload: true
				spawn: false
			assemble:
				files: 'src/hbs/*.hbs'
				tasks: [
					'watch_confirm'
					'newer:assemble'
				]

	##
	# 各タスク
	grunt.registerTask 'hello', ->
		grunt.log.writeln('hello task excuse...');

	grunt.registerTask 'watch_confirm', ->
		grunt.log.writeln('watched task...');

	# assembleの動作検証
	grunt.registerTask 'default', [ 'assemble' ]

	grunt.registerTask 'dev', [
		'hello'
		'connect'
		'watch'
	]