module.exports = (grunt) ->
	# Check time
	require('time-grunt') grunt
	# Install plugin
	require('jit-grunt') grunt

	grunt.initConfig
		#-------------------------------------------------------------------------
		# Path Setting
		path:
			src: 'src'
			dest: 'dest'
			hbs: '<%= path.src %>/hbs'
			scss: '<%= path.src %>/scss'
			css: '<%= path.dest %>/css',
			html: '<%= path.dest %>/demo'

		#-------------------------------------------------------------------------
		# connect local server
		connect:
			server:
				options:
					hostname: 'localhost'
					port: 7777
					base: 'dest/'

		#-------------------------------------------------------------------------
		# assemble
		assemble:
			options:
				partials: [
					'<%= path.hbs%>/common/*.hbs'
				]
			top:
				# options:
				# 	partials: [
				# 		'<%= path.hbs%>/common/*.hbs '
				# 	]
				files: [
					expand: true
					cwd: '<%= path.hbs %>/'
					src: '*.hbs'
					dest: '<%= path.dest %>/demo/'
				]
			# info:
			# 	files: [
			# 		expand: true
			# 		cwd: '<%= path.hbs %>/info/'
			# 		src: '**/*.hbs'
			# 		dest: '<%= path.dest %>/demo/info/'
			# 	]
			# about:
			# 	files: [
			# 		expand: true
			# 		cwd: '<%= path.hbs %>/about/'
			# 		src: '**/*.hbs'
			# 		dest: '<%= path.dest %>/demo/about/'
			# 	]

		#-------------------------------------------------------------------------
		# css
		compass:
			options:
				noLineComments: true
				debugInfo: false
				# outputStyle: 'compressed'
				force: true
			page_top:
				options:
					sassDir: '<%= path.scss %>/'
					cssDir: '<%= path.css %>/'
			# page_info:
			# 	options:
			# 		sassDir: '<%= path.scss %>/info/'
			# 		cssDir: '<%= path.css %>/info/'
			# page_about:
			# 	options:
			# 		sassDir: '<%= path.scss %>/about/'
			# 		cssDir: '<%= path.css %>/about/'

		#-------------------------------------------------------------------------
		# Imagemin
		# TODO: ファイルに変更があっても無くても常に実行されるので、newerするか？
		# TODO: mozjpegの追加
		imagemin:
			# options:
			# 	use: []
			test: 
				files: [
					expand: true     # これが無いとエラーになる, また、吐き出し側にも同名ファイルがある場合、これが無いとtaskが実行されない、という説も有り
					cwd: '<%= path.src %>/img/common/'
					src: '*.{png,jpg,svg,gif}'
					dest: '<%= path.dest %>/img/common/'
				]

		#-------------------------------------------------------------------------
		# Check
		htmlhint:
			options:
				htmlhintrc: '.htmlhintrc'
				force: true
			dev:
				src: [
					'<%= path.html %>/**/*.html'
				]
		csslint:
			dev:
				src: [
					'<%= path.css %>/**/*.css'
				]

		#-------------------------------------------------------------------------
		# Notice task process
		notify:
			assemble:
				options:
					title: 'Task Complete'
					message: 'assemble task finished'
			scss:
				options:
					title: 'Task Complete'
					message: 'scss task finished'
		# watch files, and excuse tasks
		watch:
			options:
				livereload: true
				spawn: false
			assemble:
				# TODO: 全hbsをwatchしており、1ファイル変更でも、全パブリッシュが発生する、が良いか
				files: '<%= path.hbs %>/**/*.hbs'
				tasks: [
					# MEMO: newer効いているか
					'newer:assemble'
					'notify:assemble'
				]
			compass:
				files: '<%= path.scss %>/**/*.scss'
				tasks: [
					'compass'
					'notify:scss'
				]
			csslint:
				files: [
					'<%= path.scss %>/**/*.scss'
				]
				tasks: [
					'csslint:dev'
				]
			htmlhint:
				files: [
					'<%= path.hbs %>/**/*.hbs'
				]
				tasks: [
					'htmlhint:dev'
				]

	#-------------------------------------------------------------------------
	# 各タスク
	grunt.registerTask 'task_assemble', ['assemble']
	grunt.registerTask 'task_compass', ['compass']

	grunt.registerTask 'css', [
		'csslint:dev'
	]

	grunt.registerTask 'html', [
		'htmlhint:dev'
	]

	# dev
	grunt.registerTask 'dev', [
		'connect'
		'watch'
	]

	# prod
	# hogehoge