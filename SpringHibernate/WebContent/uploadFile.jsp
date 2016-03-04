<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<body>
	<form method="POST" enctype="multipart/form-data"
		action="uploadFile.do">
		File to upload: <input type="file" name="file"><br /> <br />
		<input type="submit" value="Upload"> Press here to upload the
		file!
	</form>
	<br>
	<a href="download.do">Download</a>
</body>
</html>
