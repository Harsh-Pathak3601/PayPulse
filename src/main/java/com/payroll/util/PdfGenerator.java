package com.payroll.util;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import com.payroll.model.Employee;
import com.payroll.model.Payroll;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;

public class PdfGenerator {

    public static byte[] generatePayslipPdf(Employee emp, Payroll payroll) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        
        try {
            Document document = new Document(PageSize.A4, 40, 40, 50, 50);
            PdfWriter.getInstance(document, out);
            document.open();
            
            // --- Fonts ---
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, new Color(41, 128, 185)); // Blue
            Font companyFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.DARK_GRAY);
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);
            Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Color.BLACK);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 11, Color.DARK_GRAY);
            Font smallFont = FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY);
            
            // --- Top Header Table (Logo + Company Info) ---
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);
            headerTable.setWidths(new float[]{1f, 3f});
            
            try {
                // Attempt to load logo from common deployment paths
                String[] possiblePaths = {
                    "C:/Users/patha/OneDrive/Desktop/Employee-Payroll/src/main/webapp/public/images/logo.png",
                    "src/main/webapp/public/images/logo.png",
                    "public/images/logo.png"
                };
                
                Image logo = null;
                for (String path : possiblePaths) {
                    try {
                        logo = Image.getInstance(path);
                        if (logo != null) break;
                    } catch (Exception ignored) {}
                }

                if (logo != null) {
                    logo.scaleToFit(80, 80);
                    PdfPCell logoCell = new PdfPCell(logo);
                    logoCell.setBorder(Rectangle.NO_BORDER);
                    logoCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    headerTable.addCell(logoCell);
                } else {
                    throw new Exception("Logo not found");
                }
            } catch (Exception e) {
                PdfPCell fallback = new PdfPCell(new Phrase("PAYPULSE", titleFont));
                fallback.setBorder(Rectangle.NO_BORDER);
                fallback.setVerticalAlignment(Element.ALIGN_MIDDLE);
                headerTable.addCell(fallback);
            }
            
            PdfPCell companyCell = new PdfPCell();
            companyCell.setBorder(Rectangle.NO_BORDER);
            companyCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            companyCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            companyCell.addElement(new Paragraph("PayPulse Solutions Pvt. Ltd.", companyFont));
            companyCell.addElement(new Paragraph("Tech Park, Block A, Suite 402", normalFont));
            String monthYear = new SimpleDateFormat("MMMM yyyy").format(payroll.getPayDate());
            companyCell.addElement(new Paragraph("Salary Slip for " + monthYear, boldFont));
            headerTable.addCell(companyCell);
            
            document.add(headerTable);
            document.add(new Paragraph(" "));
            
            // Line Separator
            document.add(new Chunk(new com.lowagie.text.pdf.draw.LineSeparator(1f, 100f, Color.LIGHT_GRAY, Element.ALIGN_CENTER, -1)));
            document.add(new Paragraph(" "));
            
            // --- Employee Details Table ---
            PdfPTable empTable = new PdfPTable(4);
            empTable.setWidthPercentage(100);
            empTable.setWidths(new float[]{1.5f, 2.5f, 1.5f, 2.5f});
            empTable.setSpacingAfter(20f);
            
            addCell(empTable, "Employee Name:", boldFont); addCell(empTable, emp.getName(), normalFont);
            addCell(empTable, "Employee ID:", boldFont);   addCell(empTable, "EMP-" + emp.getEmpId(), normalFont);
            addCell(empTable, "Designation:", boldFont);   addCell(empTable, emp.getDesignation(), normalFont);
            addCell(empTable, "Department:", boldFont);    addCell(empTable, emp.getDepartment(), normalFont);
            addCell(empTable, "Paid Days:", boldFont);     addCell(empTable, String.valueOf(payroll.getPaidDays()), normalFont);
            addCell(empTable, "Total Days:", boldFont);    addCell(empTable, String.valueOf(payroll.getWorkingDays()), normalFont);
            
            document.add(empTable);
            
            // --- Salary Details Table ---
            PdfPTable salaryTable = new PdfPTable(4);
            salaryTable.setWidthPercentage(100);
            salaryTable.setWidths(new float[]{2f, 1.5f, 2f, 1.5f});
            
            // Headers
            PdfPCell c1 = new PdfPCell(new Phrase("Earnings", headerFont));
            c1.setBackgroundColor(new Color(52, 73, 94)); // Dark Blue/Grey
            c1.setPadding(8f);
            salaryTable.addCell(c1);
            
            PdfPCell c2 = new PdfPCell(new Phrase("Amount (Rs.)", headerFont));
            c2.setBackgroundColor(new Color(52, 73, 94));
            c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c2.setPadding(8f);
            salaryTable.addCell(c2);
            
            PdfPCell c3 = new PdfPCell(new Phrase("Deductions", headerFont));
            c3.setBackgroundColor(new Color(52, 73, 94));
            c3.setPadding(8f);
            salaryTable.addCell(c3);
            
            PdfPCell c4 = new PdfPCell(new Phrase("Amount (Rs.)", headerFont));
            c4.setBackgroundColor(new Color(52, 73, 94));
            c4.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c4.setPadding(8f);
            salaryTable.addCell(c4);
            
            // Rows
            addSalaryRow(salaryTable, "Basic Salary", payroll.getBasicSalary(), "Provident Fund (PF)", payroll.getPfDeduction(), normalFont);
            addSalaryRow(salaryTable, "House Rent Allowance (HRA)", payroll.getHra(), "ESI", payroll.getEsiDeduction(), normalFont);
            addSalaryRow(salaryTable, "Dearness Allowance (DA)", payroll.getDa(), "TDS", payroll.getTdsDeduction(), normalFont);
            addSalaryRow(salaryTable, "Bonus", payroll.getBonus(), "Loss of Pay (LOP)", payroll.getLopDeduction(), normalFont);
            
            // Totals Row
            PdfPCell t1 = new PdfPCell(new Phrase("Total Earnings", boldFont));
            t1.setPadding(8f); t1.setBackgroundColor(new Color(236, 240, 241));
            salaryTable.addCell(t1);
            
            PdfPCell t2 = new PdfPCell(new Phrase(String.format("%.2f", payroll.getGrossSalary()), boldFont));
            t2.setHorizontalAlignment(Element.ALIGN_RIGHT); t2.setPadding(8f); t2.setBackgroundColor(new Color(236, 240, 241));
            salaryTable.addCell(t2);
            
            PdfPCell t3 = new PdfPCell(new Phrase("Total Deductions", boldFont));
            t3.setPadding(8f); t3.setBackgroundColor(new Color(236, 240, 241));
            salaryTable.addCell(t3);
            
            double totalDeductions = payroll.getPfDeduction() + payroll.getEsiDeduction() + payroll.getTdsDeduction() + payroll.getLopDeduction();
            PdfPCell t4 = new PdfPCell(new Phrase(String.format("%.2f", totalDeductions), boldFont));
            t4.setHorizontalAlignment(Element.ALIGN_RIGHT); t4.setPadding(8f); t4.setBackgroundColor(new Color(236, 240, 241));
            salaryTable.addCell(t4);
            
            document.add(salaryTable);
            document.add(new Paragraph(" "));
            
            // --- Net Payable ---
            PdfPTable netTable = new PdfPTable(2);
            netTable.setWidthPercentage(100);
            netTable.setWidths(new float[]{3f, 1f});
            
            PdfPCell n1 = new PdfPCell(new Phrase("NET PAYABLE", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.WHITE)));
            n1.setBackgroundColor(new Color(39, 174, 96)); // Green
            n1.setPadding(10f);
            netTable.addCell(n1);
            
            PdfPCell n2 = new PdfPCell(new Phrase("Rs. " + String.format("%.2f", payroll.getNetSalary()), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.WHITE)));
            n2.setBackgroundColor(new Color(39, 174, 96));
            n2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            n2.setPadding(10f);
            netTable.addCell(n2);
            
            document.add(netTable);
            
            // --- Footer ---
            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));
            Paragraph footer = new Paragraph("This is a computer generated document and does not require a physical signature.", smallFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);
            
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return out.toByteArray();
    }
    
    private static void addCell(PdfPTable table, String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPaddingBottom(8f);
        table.addCell(cell);
    }
    
    private static void addSalaryRow(PdfPTable table, String earnLabel, double earnVal, String dedLabel, double dedVal, Font font) {
        PdfPCell c1 = new PdfPCell(new Phrase(earnLabel, font));
        c1.setPadding(6f); c1.setBorderColor(Color.LIGHT_GRAY);
        table.addCell(c1);
        
        String eVal = earnVal == 0 && earnLabel.trim().isEmpty() ? "" : String.format("%.2f", earnVal);
        PdfPCell c2 = new PdfPCell(new Phrase(eVal, font));
        c2.setHorizontalAlignment(Element.ALIGN_RIGHT); c2.setPadding(6f); c2.setBorderColor(Color.LIGHT_GRAY);
        table.addCell(c2);
        
        PdfPCell c3 = new PdfPCell(new Phrase(dedLabel, font));
        c3.setPadding(6f); c3.setBorderColor(Color.LIGHT_GRAY);
        table.addCell(c3);
        
        String dVal = dedVal == 0 && dedLabel.trim().isEmpty() ? "" : String.format("%.2f", dedVal);
        PdfPCell c4 = new PdfPCell(new Phrase(dVal, font));
        c4.setHorizontalAlignment(Element.ALIGN_RIGHT); c4.setPadding(6f); c4.setBorderColor(Color.LIGHT_GRAY);
        table.addCell(c4);
    }
}
