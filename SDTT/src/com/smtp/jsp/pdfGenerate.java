package com.smtp.jsp;

import java.io.*;
import java.sql.*;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.util.*;

public class pdfGenerate{
	public static ArrayList<String> slot=new ArrayList<String>();
	
    public static void main(String arg[])throws Exception{
       Document document=new Document();
       PdfWriter.getInstance(document,new FileOutputStream("C:\\Users\\atulw\\OneDrive\\b.pdf"));
       document.open();
       //Image image = Image.getInstance("C:\\Users\\atulw\\Downloads\\logo3.jpg");

       // scale the image to 50px height
      // image.scaleAbsoluteHeight(50);
       //image.scaleAbsoluteWidth((image.getWidth() * 50) / image.getHeight());
       //image.setAbsolutePosition(10f, 10f);
       //document.add(image);
       
       document.add(new Phrase("    "));
       
       PdfPTable table=new PdfPTable(7);
       table.addCell("SlotID");
       table.addCell("ProfessorID");
       table.addCell("Subject ID");
       table.addCell("Div ID");
       table.addCell("TimeSlot");
       table.addCell("Room");
       table.addCell("Day");
       Class.forName("com.mysql.cj.jdbc.Driver");
       Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tt", "root", "mysql");
       Statement st=con.createStatement();
       ResultSet rs=st.executeQuery("Select * from timetable");
       while(rs.next()){
    	   slot.add(rs.getString("slotID"));
    	   slot.add(rs.getString("Professor_id"));
    	   slot.add(rs.getString("sub_id"));
    	   slot.add(rs.getString("div_id"));
    	   slot.add(rs.getString("timeslot"));
    	   slot.add(rs.getString("Room"));
    	   slot.add(rs.getString("day"));
       }
       
       int n=0;
      for(int i=1;i<=slot.size();i++)
      {
    	  PdfPCell cell=new PdfPCell();
    	  while(i%7!=0)
    	  {
    		cell.addElement(new Phrase(slot.get(i-1)));
    		i++;
    	  }
    	  table.addCell(cell);
      }
      
       document.add(table);
       document.close();
   }
}