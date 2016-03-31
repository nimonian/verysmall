import os, re

def create_course(course):
	coursedir = './%s'%(course)
	if not os.path.exists(coursedir):
		os.mkdir(coursedir)
		print 'Course directory created: %s'%(course)
	else:
		print 'Course already exists: %s'%(course)
		return

	masterfile = coursedir + '/%s.tex'%(course)

	mastertemplate = r'''\documentclass[12pt]{article}
\usepackage{classnotes}
\usepackage{subfiles}


\title{A Level Mathematics \\ %s}
\author{}
\date{}

\begin{document}

\pagenumbering{gobble}

\maketitle

\begin{center}
\includegraphics[width=8cm]{../jcclogo.PNG}
\end{center}

\newpage

\thispagestyle{plain}
\tableofcontents

\end{document}'''%(course.upper())

	if not os.path.exists(masterfile):
		f = file(masterfile, 'w+')
		f.write(mastertemplate)
		f.close()
		print 'Master file created: %s.tex'%(course)

def create_topic(course,topic):
	coursedir = './%s'%(course)
	topicdir = 	coursedir + '/%s'%(topic)
	materials = ['examples', 'exercises', 'proofs', 'homework', 'test']

	testtemplate = r'''
\documentclass[../%s]{subfiles}

\begin{document}

\subsection*{%s Assessment}
\thispagestyle{fancy}

\input{/home/simon/io/verysmall/classnotes/%s/%s/test.txt}

\begin{flushright}
\textbf{Total marks: []}
\end{flushright}

\end{document}'''%(course, topic[0].upper() + topic[1:],course,topic)

	homeworktemplate = r'''
\documentclass[../%s]{subfiles}

\begin{document}

\subsection*{%s Assessed Homework}
\thispagestyle{fancy}

\input{/home/simon/io/verysmall/classnotes/%s/%s/homework.txt}

\begin{flushright}
\textbf{Total marks: []}
\end{flushright}

\end{document}'''%(course, topic[0].upper() + topic[1:],course,topic)

	exercisetemplate = r'''
\documentclass[../%s]{subfiles}

\begin{document}

\subsection*{%s Exercises}
\thispagestyle{fancy}

\input{/home/simon/io/verysmall/classnotes/%s/%s/exercises.txt}

\end{document}'''%(course, topic[0].upper() + topic[1:],course,topic)

	examplestemplate = r'''
\documentclass[../%s]{subfiles}

\begin{document}

\subsection*{%s Examples}
\thispagestyle{fancy}

\input{/home/simon/io/verysmall/classnotes/%s/%s/examples.txt}

\end{document}'''%(course, topic[0].upper() + topic[1:], course, topic)

	proofstemplate = r'''
\documentclass[../%s]{subfiles}

\begin{document}

\subsection*{%s Proofs}
\thispagestyle{fancy}

\begin{theorem}[]

\end{theorem}
\end{document}'''%(course, topic[0].upper() + topic[1:])

	if not os.path.exists(coursedir):
		return 'Error - No such course exists: %s'%(course)

	if not os.path.exists(topicdir):
		os.mkdir(topicdir)
		print 'Topic directory created: %s'%(topic)

		masterfile = open(coursedir + '/%s.tex'%(course), 'r')
		mastercontent = masterfile.read()
		masterfile.close()

		mastercontent = mastercontent.replace(r'\end{document}',r'''
			\newpage
			\section{%s}

			\end{document}'''%(topic[0].upper() + topic[1:]))

		masterfile = open(coursedir + '/%s.tex'%(course), 'w')
		masterfile.write(mastercontent)
		masterfile.close()

	else:
		print 'Topic already exists: %s'%(topic)
	
	for m in materials:
		mpath = topicdir + '/%s.tex'%(m)

		if not os.path.exists(mpath):
			masterfile = open(coursedir + '/%s.tex'%(course), 'r')
			mastercontent = masterfile.read()
			masterfile.close()
			
			mastercontent = mastercontent.replace(r'\end{document}',r'''
				\newpage
				\subfile{%s}

				\end{document}'''%(r'./%s/%s.tex'%(topic,m)))

			masterfile = open(coursedir + '/%s.tex'%(course), 'w')
			masterfile.write(mastercontent)
			masterfile.close()

	
		f = file(mpath, 'w+')
		if not os.path.exists(mpath.replace('tex','txt')):	
			g = file(mpath.replace('tex','txt'),'w+')
		
		if m == 'homework':
			f.write(homeworktemplate)
		if m == 'exercises':
			f.write(exercisetemplate)
		if m == 'examples':
			f.write(examplestemplate)
		if m == 'proofs':
			f.write(proofstemplate)
		if m == 'test':
			f.write(testtemplate)
			
		f.close()
		print 'Material created: %s.tex'%(m)

def calculate_totals():
	probEx = re.compile(r'(\prob\[)(\d)')
	for path in os.walk(os.path.abspath('.')):
		for base in path[2]:
			if base in ['homework.txt','test.txt']:
				total = 0
				file = path[0] + '/' + base

				f = open(file, 'r')
				content = f.read()

				if probEx.findall(content):
					for prob in probEx.findall(content):
						total += int(prob[1])

				f.close()

				file = file.replace('.txt','.tex')

				f = open(file, 'r')
				content = f.read()
				f.close()

				f = open(file, 'w')

				content = re.sub(r'Total marks: \[.*\]',r'Total marks: [%s]'%(total),content)

				f.write(content)
				f.close()

def teacher_materials():
	for path in os.walk(os.path.abspath('.')):
		for base in path[2]:
			if base == 'examples.txt':
				file = path[0] + '/' + base
				texfile = file.replace('.txt','.tex')
				f = open(file, 'r')
				content = f.read()
				f.close()
				
				content = re.sub(r'\\begin{example}',r'\\newpage \\begin{example}',content)

				file = file.replace('examples','examplesteacher')
				f = open(file,'w')
				f.write(content)
				f.close()

				t = open(texfile,'r')
				template = t.read()
				t.close()
				template = re.sub(r'\\input{.*}',r'\input{%s}'%(file),template)

				texfile = texfile.replace('examples','examplesteacher')
				t = open(texfile,'w')
				t.write(template)
				t.close()

			if base == 'proofs.txt':
				file = path[0] + '/' + base
				texfile = file.replace('.txt','.tex')
				f = open(file, 'r')
				content = f.read()
				f.close()
				
				content = re.sub(r'\\begin{theorem}',r'\\newpage \\begin{theorem}',content)

				file = file.replace('proofs','proofssteacher')
				f = open(file,'w')
				f.write(content)
				f.close()

				t = open(texfile,'r')
				template = t.read()
				t.close()
				template = re.sub(r'\\input{.*}',r'\input{%s}'%(file),template)

				texfile = texfile.replace('proofs','proofsteacher')
				t = open(texfile,'w')
				t.write(template)
				t.close()

			if base == 'homework.txt':
				file = path[0] + '/' + base
				texfile = file.replace('.txt','.tex')
				f = open(file, 'r')
				content = f.read()
				f.close()
				
				content = re.sub(r'\%Question',r'\\newpage %Question',content)

				file = file.replace('homework','homeworkteacher')
				f = open(file,'w')
				f.write(content)
				f.close()

				t = open(texfile,'r')
				template = t.read()
				t.close()
				template = re.sub(r'\\input{.*}',r'\input{%s}'%(file),template)

				texfile = texfile.replace('homework','homeworkteacher')
				t = open(texfile,'w')
				t.write(template)
				t.close()

			if base == 'test.txt':
				file = path[0] + '/' + base
				texfile = file.replace('.txt','.tex')
				f = open(file, 'r')
				content = f.read()
				f.close()
				
				content = re.sub(r'\%Question',r'\\newpage %Question',content)

				file = file.replace('test','testteacher')
				f = open(file,'w')
				f.write(content)
				f.close()

				t = open(texfile,'r')
				template = t.read()
				t.close()
				template = re.sub(r'\\input{.*}',r'\input{%s}'%(file),template)

				texfile = texfile.replace('test','testteacher')
				t = open(texfile,'w')
				t.write(template)
				t.close()

			if base == 'exercises.txt':
				file = path[0] + '/' + base
				texfile = file.replace('.txt','.tex')
				f = open(file, 'r')
				content = f.read()
				f.close()
				
				content = re.sub(r'\%Question',r'\\newpage %Question',content)

				file = file.replace('exercises','exercisesteacher')
				f = open(file,'w')
				f.write(content)
				f.close()

				t = open(texfile,'r')
				template = t.read()
				t.close()
				template = re.sub(r'\\input{.*}',r'\input{%s}'%(file),template)

				texfile = texfile.replace('exercises','exercisesteacher')
				t = open(texfile,'w')
				t.write(template)
				t.close()



S1 = ['measures', 'probability', 'binomial', 'correlation', 'regression', 'normal', 'confidence']
C1 = ['algebra','surds','geometry','quadratics1','quadratics2','polynomials','circles','differentiation','integration']

create_course('s1')

for topic in S1:
	create_topic('s1',topic)

calculate_totals()
teacher_materials()