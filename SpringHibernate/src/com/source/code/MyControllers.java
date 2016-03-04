package com.source.code;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class MyControllers {

	@Autowired
	private MyDaos dao;

	private String alert = "";
	private String login = "";
	private String status = "";
	private String username = "";
	private String photo="";
	private List<Document> ls;

	@RequestMapping("/home")
	public ModelAndView getAllContacts(@ModelAttribute("object") Join object) {
		login = "";
		status="";
		Map map = new HashMap();
		ls = dao.getAllDocuments();
		map.put("ls", ls);
		map.put("alert", alert);
		map.put("status", status);
		ModelAndView mav = new ModelAndView("home", map);
		List<Document> documents = dao.getAllDocuments();
		mav.addObject("documents", documents);
		return mav;
	}

	@RequestMapping("/register")
	public String register(@RequestParam("file") MultipartFile file,
			HttpServletRequest request) {
		Join o = new Join();
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		String email = request.getParameter("email");
		String status = request.getParameter("status");
		ls = dao.getAllDocuments();
		request.setAttribute("ls", ls);
		o.setEmail(email);
		o.setName(name);
		o.setPassword(pass);
		o.setStatus(status);
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				String rootPath = request.getServletContext().getRealPath("");
				File dir = new File(rootPath + File.separator + "img");
				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + file.getOriginalFilename());
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				photo = file.getOriginalFilename();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			o.setPhoto(photo);
			dao.register(o);
			alert = "Register success, you can login now";
			request.setAttribute("alertClass", "alert-success");
			request.setAttribute("alert", alert);
			request.setAttribute("status", "student");
			return "home";
		} catch (Exception e) {
			// TODO: handle exception
			alert = "Register failed, please check your data";
			request.setAttribute("alertClass", "alert-danger");
			request.setAttribute("status", "student");
			request.setAttribute("alert", alert);
			return "home";
		}
	}

	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request) {
		Map map = new HashMap();
		ls = dao.getAllDocuments();
		map.put("ls", ls);
		ModelAndView mav;
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		Join j = dao.login(name, pass);
		if (j != null) {
			login=j.getName();
			status=j.getStatus();
			username = j.getName();
			photo="img/" + j.getPhoto();
			map.put("login", login);
			map.put("status", status);
			map.put("photo", photo);
			mav = new ModelAndView("home", map);
		} else {
			alert = "Login failed, please check your username & password!";
			map.put("login", login);
			map.put("alert", alert);
			map.put("alertClass", "alert-danger");
			map.put("status", status);
			mav = new ModelAndView("home", map);
		}
		return mav;
	}

	@RequestMapping("/logout")
	public ModelAndView logout() {
		Map map = new HashMap();
		ls = dao.getAllDocuments();
		map.put("ls", ls);
		login = "";
		status="";
		map.put("login", login);
		map.put("status", status);
		ModelAndView mav = new ModelAndView("home", map);
		return mav;
	}

	@RequestMapping("/uploadFile")
	public String handleFileUpload(@RequestParam("file") MultipartFile file,
			HttpServletRequest request) {
		String name = request.getParameter("name");
		String uploadBy = username;
		Date uploadDate = new Date();
		int count = 0;
		request.setAttribute("photo", photo);
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				String rootPath = request.getServletContext().getRealPath("");
				File dir = new File(rootPath + File.separator + "img");
				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + file.getOriginalFilename());
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				Document d = new Document();
				d.setDownloadCount(count);
				d.setName(name);
				d.setUplaodBy(uploadBy);
				d.setUploadDate(uploadDate);
				d.setOriginalName(file.getOriginalFilename());
				dao.save(d);
				ls = dao.getAllDocuments();
				request.setAttribute("ls", ls);
				alert = "Upload file success";
				request.setAttribute("alertClass", "alert-success");
				request.setAttribute("alert", alert);
				request.setAttribute("status", status);
				request.setAttribute("login", login);
				return "home";
			} catch (Exception e) {
				e.printStackTrace();
				ls = dao.getAllDocuments();
				request.setAttribute("ls", ls);
				alert = "Upload file failed!";
				request.setAttribute("alertClass", "alert-danger");
				request.setAttribute("status", status);
				request.setAttribute("login", login);
				request.setAttribute("alert", alert);
				return "home";
			}
		} else {
			ls = dao.getAllDocuments();
			request.setAttribute("ls", ls);
			alert = "Upload file failed, file cannot be empty!";
			request.setAttribute("alertClass", "alert-danger");
			request.setAttribute("status", status);
			request.setAttribute("alert", alert);
			request.setAttribute("login", login);
			return "home";
		}
	}

	@RequestMapping("/download/{id}")
	public void doDownload(@PathVariable("id")int id, HttpServletRequest request,
			HttpServletResponse response) throws IOException {

		Document d=dao.getById(id);
		
		// get absolute path of the application
		ServletContext context = request.getServletContext();
		String appPath = context.getRealPath("");
		System.out.println("appPath = " + appPath);

		String filePath = "/img/"+d.getOriginalName();
		// construct the complete absolute path of the file
		String fullPath = appPath + filePath;
		File downloadFile = new File(fullPath);
		FileInputStream inputStream = new FileInputStream(downloadFile);

		// get MIME type of the file
		String mimeType = context.getMimeType(fullPath);
		if (mimeType == null) {
			// set to binary type if MIME mapping not found
			mimeType = "application/octet-stream";
		}
		System.out.println("MIME type: " + mimeType);

		// set content attributes for the response
		response.setContentType(mimeType);
		response.setContentLength((int) downloadFile.length());

		// set headers for the response
		String headerKey = "Content-Disposition";
		String headerValue = String.format("attachment; filename=\"%s\"",
				downloadFile.getName());
		response.setHeader(headerKey, headerValue);

		// get output stream of the response
		OutputStream outStream = response.getOutputStream();

		byte[] buffer = new byte[4096];
		int bytesRead = -1;

		// write bytes read from the input stream into the output stream
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, bytesRead);
		}

		d.setDownloadCount(d.getDownloadCount()+1);
		dao.update(d);
		inputStream.close();
		outStream.close();

	}
}
