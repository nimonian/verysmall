<!DOCTYPE html>
<html>
	<head>
		<?php
			$file = 'fp1/calculus/indefinite_integral_polynomial.sage';
			$sagecode = file_get_contents($file);
		?>

		<title>Rudiment Designer</title>

		<link rel="stylesheet" type="text/css" href="designer.css">

        <script type="text/x-mathjax-config">
        	MathJax.Hub.Config({
        		jax: ["input/TeX","output/HTML-CSS"],
        		displayAlign: "left"
        		});
		</script>

        <script type="text/javascript"
            src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
        </script>

		<script src="https://sagecell.sagemath.org/static/jquery.min.js"></script>
		<script src="https://sagecell.sagemath.org/static/embedded_sagecell.js"></script>
		<script>sagecell.makeSagecell({
            "inputLocation": ".sage",
            evalButtonText: "Problem",
            hide: ["editor", "permalink"]
        	});
		</script>

		<link rel="stylesheet" type="text/css" href="https://sagecell.sagemath.org/static/sagecell_embed.css">
	</head>
	
	<body>
		<nav>
    		<ul>
        		<li><a href="/">Hoooome</a></li>
	        	<li><a href="/about">About</a></li>
        		<li><a href="/cv">CV</a></li>
        		<li><a href="/blog">Blog</a></li>
    		</ul>
		</nav>

		<form name="rudiment1" method="get" action="index.php">
			<input type="text" value="course" name="course">
			<input type="text" value="chapter" name="chapter">
			<input type="text" value="rudiment" name="rudiment">
			<input type="submit" name="Submit1" value="go">
		</form>

		<br />

		<?php
			$course = $_GET['course'];
			$chapter = $_GET['chapter'];
			$rudiment = $_GET['rudiment'];
			$file = $course.'/'.$chapter.'/'.$rudiment.'.sage';
			$sagecode = file_get_contents($file);
			echo $file;
		?>

		<br />
		<br />

		<div class="container">
    		<div class="sage">
				<script type="text/x-sage">
				<?php echo $sagecode; ?>
				</script>
				</div>
		</div>
		<footer>
    		<ul>
        		<li><a href="mailto:nimon@hotmail.co.uk">email</a></li>
        		<li><a href="https://github.com/nimonian">github.com/nimonian</a></li>
			</ul>
		</footer>
	</body>
</html>
