


import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;

import sss.Facade;
import sss.config.Algorithms;
import sss.config.Encryptors;
import sss.config.RandomSources;
import sss.crypto.data.Share;

/**
 * Author: Shaun Mutch
 * Description: Servlet responsible for creating and splitting 
 * secret shares. Implements the use of file parts and external
 * libraries to split and rebuild files.
 */

@SuppressWarnings("unused")
@WebServlet("/Engine")
@MultipartConfig(maxFileSize = 16177215)    // 16MB file limit
public class Engine extends HttpServlet implements Serializable {
	private static final long serialVersionUID = 1L;

	// size of byte buffer to send file
	private static final int BUFFER_SIZE = 4096;   


	public Engine() {
		super();
	}


	// Populate file system and rebuild files via cloudlet
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ResultSet rs = (ResultSet) request.getAttribute("rSet"); 


		if (rs == null) {
			String selected = request.getParameter("param").toString();
			request.setAttribute("id", selected);
			RequestDispatcher rd = request.getRequestDispatcher("Cloudlet");
			rd.forward(request,response);
		} 

		// Rebuild secret share
		else {
			try {
				if (rs.next()) {
					
					int n = 4;
					int t = 4;
					RandomSources r = RandomSources.SHA1;
					Encryptors e = Encryptors.ChaCha20;
					Algorithms a = Algorithms.CSS;
					
					Facade f = new Facade(n, t, r, e, a);
					
					String fileName = rs.getString(2);
					byte[] getBytes = rs.getBytes(6);
					byte[] getFacade = rs.getBytes(7);
					
					// Deserialize share and facade from bytes
					ByteArrayInputStream bStream = new ByteArrayInputStream(getBytes);

					InputStream inputStream = new ByteArrayInputStream(getBytes);
					int fileLength = inputStream.available();

					ServletContext context = getServletContext();

					// sets MIME type for the file download
					String mimeType = context.getMimeType(fileName);
					if (mimeType == null) {        
						mimeType = "application/octet-stream";
					}              

					// set content properties and header attributes for the response
					response.setContentType(mimeType);
					response.setContentLength(fileLength);
					String headerKey = "Content-Disposition";
					String headerValue = String.format("attachment; filename=\"%s\"", fileName);
					response.setHeader(headerKey, headerValue);

					// writes the file to the client
					OutputStream outStream = response.getOutputStream();

					byte[] buffer = new byte[BUFFER_SIZE];
					int bytesRead = -1;

					while ((bytesRead = inputStream.read(buffer)) != -1) {
						outStream.write(buffer, 0, bytesRead);
					}

					inputStream.close();
					outStream.close(); 
				}
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}


	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get file name from class path
		Part filePart = request.getPart("file"); 
		String fileName = getSubmittedFileName(filePart);

		// Check file has been selected
		if (filePart.getSize() != 0) {

			// Prepare SSS variables
			int n = Integer.parseInt(request.getParameter("nvalue"));
			int t = Integer.parseInt(request.getParameter("tvalue"));
			RandomSources r = RandomSources.SHA1;
			Encryptors e = Encryptors.ChaCha20;
			Algorithms a = Algorithms.CSS;
			
			try {

				// Split inputstream into secret shares
				Facade f = new Facade(n, t, r, e, a);
				InputStream inputStream = filePart.getInputStream();
				byte[] bytes = IOUtils.toByteArray(inputStream);
				
				// Split bytes to shares
				Share[] shares = f.split(bytes);

				ByteArrayOutputStream bStream = new ByteArrayOutputStream();
				ObjectOutputStream oStream = new ObjectOutputStream(bStream);
				
				// Serialize each share for blob storage
				for (int i=0; i<shares.length; i++){
				oStream.writeObject(shares[i].serialize());
				}
				
				byte[] sBytes = bStream.toByteArray();
				
				// Facade
				ByteArrayOutputStream fbStream = new ByteArrayOutputStream();
				ObjectOutputStream foStream = new ObjectOutputStream( fbStream );
				foStream.writeObject(f.getClass().isArray());
				
				byte[] fBytes = fbStream.toByteArray();
				
				// Prepare shares for Cloudlet and redirect
				request.setAttribute("secretFile", bytes);
				request.setAttribute("fileName", fileName);
				request.setAttribute("nvalue", n);
				request.setAttribute("tvalue", t);
				request.setAttribute("fvalue", fBytes);
				
				RequestDispatcher rd = request.getRequestDispatcher("Cloudlet");
				rd.forward(request,response);

				// Error handling
			} catch(Exception ex) {
				ex.printStackTrace();
			}
		} else {
			request.setAttribute("errMsg", "No file selected");
			RequestDispatcher rd = request.getRequestDispatcher("Upload.jsp");
			rd.forward(request, response); 
		}
	}


	// Method to extract filename from file path
	private static String getSubmittedFileName(Part part) {
		for (String cd : part.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
			}
		}
		return null;
	}
	
}

