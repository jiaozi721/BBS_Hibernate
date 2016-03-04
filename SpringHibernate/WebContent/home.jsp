<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>JEE</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/grayscale.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.css" rel="stylesheet"
	type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">

	<!-- Navigation -->
	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-main-collapse">
					<i class="fa fa-bars"></i>
				</button>
				<a class="navbar-brand page-scroll" href="#page-top"> <i
					class="fa fa-play-circle"></i> <span class="light">Home</span>
				</a> <a class="navbar-brand page-scroll" href="#documents">Documents</a>
				<a class="navbar-brand page-scroll" href="#about">Information</a> <a
					class="navbar-brand page-scroll" href="#download" id="down">Download</a><a
					class="navbar-brand page-scroll" href="#upload" id="up">Upload</a>

			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div
				class="collapse navbar-collapse navbar-right navbar-main-collapse">
				<ul class="nav navbar-nav">
					<!-- Hidden li included to remove active class from about link when scrolled up past about section -->
					<li class="hidden"><a href="#page-top"></a></li>
					<li><a class="page-scroll" href="#register" id="reg">Register</a></li>
					<li><a class="page-scroll" href="#login" id="logi">Login</a></li>
					<li><a class="page-scroll" href="logout.do" id="logout">Logout</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<!-- Intro Header -->
	<header class="intro">
		<div class="intro-body">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2">

						<c:if test="${not empty login}">
							<img alt="140x140" src="${photo}" class="img-circle" />
							<h1 class="brand-heading">
								<c:out value="${login}"></c:out>
							</h1>
							<p class="intro-text">Welcome in your account.</p>
							<a href="#about" class="btn btn-circle page-scroll"> <i
								class="fa fa-angle-double-down animated"></i>
							</a>
						</c:if>
						<c:if test="${empty login}">
							<h1 class="brand-heading">Welcome</h1>
							<p class="intro-text">
								You can <a class="page-scroll" href="#register">create an
									account</a> or <a class="page-scroll" href="#login">login</a><br> to search and
									download document.<br>
							</p>
							<a href="#about" class="btn btn-circle page-scroll"> <i
								class="fa fa-angle-double-down animated"></i>
							</a>
						</c:if>
						<c:if test="${not empty alert }">
							<div class="alert ${alertClass} alert-dismissable">
								<button type="button" class="close" data-dismiss="alert"
									aria-hidden="true">×</button>
								<c:out value="${alert}"></c:out>
								<a href="#" class="alert-link">alert link</a>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- Documents Section -->
	<section id="documents" class="container content-section text-center">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<h2>Documents</h2>
				<table class="table table-hover" id="myTable1">
					<thead>
						<tr align="center">
							<th>#</th>
							<th>Name</th>
							<th>Upload By</th>
							<th>Upload Date</th>
							<th>Download Count</th>
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
						%>
						<c:forEach items="${ls}" var="d">
							<tr style="background: transparent;">
								<td><%=i%></td>
								<td><c:out value="${d.name}"></c:out></td>
								<td><c:out value="${d.uplaodBy}"></c:out></td>
								<td><c:out value="${d.uploadDate}"></c:out></td>
								<td><c:out value="${d.downloadCount}"></c:out></td>
							</tr>
							<%
								i++;
							%>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>

	<!-- About Section -->
	<section id="about" class="content-section text-center">
		<div class="download-section">
			<div class="container">
				<div class="col-lg-8 col-lg-offset-2">
					<h2>Information</h2>
					<p>
						This website was built with <a href="http://getbootstrap.com/">
							Bootstrap 3 </a> for user interface, <a
							href="http://projects.spring.io/spring-framework/">Spring
							framework</a> for service, and <a href="http://hibernate.org/">
							hibernate ORM</a> for object relational mapping to database.
					</p>
					<p>
						<a href="http://projects.spring.io/spring-framework/">The
							Spring framework</a> provides a comprehensive programming and
						configuration model for modern Java-based enterprise applications
						- on any kind of deployment platform. A key element of Spring is
						infrastructural support at the application level: Spring focuses
						on the "plumbing" of enterprise applications so that teams can
						focus on application-level business logic, without unnecessary
						ties to specific deployment environments.
					</p>
					<p>
						<a href="http://hibernate.org/"> Hibernate ORM</a> enables
						developers to more easily write applications whose data outlives
						the application process. As an Object/Relational Mapping (ORM)
						framework, Hibernate is concerned with data persistence as it
						applies to relational databases (via JDBC).
					</p>
				</div>
			</div>
		</div>
	</section>


	<!-- download Section -->
	<section id="download" class="content-section text-center">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<h2>Dowload</h2>
				<table class="table table-hover" id="myTable2">
					<thead>
						<tr align="center">
							<th>#</th>
							<th>Name</th>
							<th>Upload By</th>
							<th>Upload Date</th>
							<th>Download Count</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
							int j = 1;
						%>
						<c:forEach items="${ls}" var="d">
							<tr style="background: transparent;">
								<td><%=j%></td>
								<td><c:out value="${d.name}"></c:out></td>
								<td><c:out value="${d.uplaodBy}"></c:out></td>
								<td><c:out value="${d.uploadDate}"></c:out></td>
								<td><c:out value="${d.downloadCount}"></c:out></td>
								<td><a href="download/${d.id}.do">Download</a></td>
							</tr>
							<%
								j++;
							%>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<!-- upload Section -->
	<section id="upload" class="container content-section text-center">
		<div class="download-section">
			<div class="container">
				<div class="col-lg-8 col-lg-offset-2">
					<h2>Upload</h2>
					<form class="form-horizontal" role="form" method="post"
						action="uploadFile.do" enctype="multipart/form-data">
						<div class="form-group">
							<label for="inputEmail3" class="col-lg-2 control-label">Name</label>
							<div class="col-lg-8">
								<input type="text" class="form-control" name="name" />
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-lg-2 control-label">Choose</label>
							<div class="col-lg-8">
								<input type="file" class="form-control" name="file" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-8">
								<button type="submit" class="btn btn-default">Upload</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- register Section -->
	<section id="register" class="content-section text-center">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<h2>Register</h2>
				<form class="form-horizontal" role="form" method="post"
					action="register.do" enctype="multipart/form-data">
					<div class="form-group">
						<label for="inputPassword3" class="col-lg-2 control-label">Username</label>
						<div class="col-lg-8">
							<input type="text" class="form-control" name="name" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-lg-2 control-label">Password</label>
						<div class="col-lg-8">
							<input type="password" class="form-control" name="pass" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputEmail3" class="col-lg-2 control-label">Email</label>
						<div class="col-lg-8">
							<input type="email" class="form-control" name="email" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputStatus3" class="col-lg-2 control-label">status(teacher or student)</label>
						<div class="col-lg-8">
							<input type="radio"  name="status"  value="student"/>Student
							 <input type="radio" name="status"  value="teacher"/>Teacher
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword3" class="col-lg-2 control-label">Photo</label>
						<div class="col-lg-8">
							<input type="file" class="form-control" name="file" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-8">
							<button type="submit" class="btn btn-default">Register</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>

	<!-- login Section -->
	<section id="login" class="container content-section text-center">
		<div class="download-section">
			<div class="container">
				<div class="col-lg-8 col-lg-offset-2">
					<h2>Login</h2>
					<form class="form-horizontal" role="form" action="login.do"
						method="post">
						<div class="form-group">
							<label for="inputEmail3" class="col-lg-2 control-label">Username</label>
							<div class="col-lg-8">
								<input type="text" class="form-control" name="name" />
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-lg-2 control-label">Password</label>
							<div class="col-lg-8">
								<input type="password" class="form-control" name="pass" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-8">
								<button type="submit" class="btn btn-default">Sign in</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<!-- 	<!-- Map Section -->

	<div id="map"></div>

	<!-- Footer -->
	<footer>
		<div class="container text-center">
			<p>Copyright &copy; My Website 2015</p>
		</div>
	</footer>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.js"></script>

	<!-- Plugin JavaScript -->
	<script src="js/jquery.easing.min.js"></script>

	<!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
	<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

	<!-- Custom Theme JavaScript -->
	<script src="js/grayscale.js"></script>
	<!-- Data Tables -->
	<script src="js/jquery.dataTables.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#myTable1').DataTable({
				bFilter : false
			});
			$('#myTable2').DataTable();
			var login = '${login}';
			var status = '${status}';
			if (status == 'teacher') {
				$('#up, #upload, #down, #download').show();
			} else if (status == 'student') {
				$('#up, #upload').hide();
			} else {
				$('#up, #upload, #down, #download').hide();
			}

			if (login == "") {
				$('#reg, #logi, #register, #login').show();
				$('#logout').hide();
			} else {
				$('#reg, #logi, #register, #login').hide();
				$('#logout').show();
			}
		});
	</script>

</body>

</html>
