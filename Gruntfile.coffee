module.exports = (grunt) ->
	require('time-grunt') grunt
	require('jit-grunt') grunt

	grunt.initConfig
		# connect local server
		connect:
			server:
				options:
					hostname: 'localhost'
					port: 7777
					base: 'dist/'
		# assemble setting
		assemble:
			test:
				options:
					files: [
						expand: true
						# cwd: 'src/hbs/'
						src: 'src/hbs/*.hbs'
						dest: 'dist/demo/'
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

	grunt.registerTask 'dev', [
		'hello'
		'connect'
		'watch'
	]