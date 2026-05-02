package com.payroll.util;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;
import java.util.Properties;
import java.text.SimpleDateFormat;
import com.payroll.model.Employee;
import com.payroll.model.Payroll;

public class EmailService {

    private static final Dotenv dotenv = Dotenv.configure()
            .ignoreIfMissing()
            .load();

    private static final String SMTP_HOST = getEnv("SMTP_HOST");
    private static final String SMTP_PORT = getEnv("SMTP_PORT");
    private static final String SMTP_USER = getEnv("SMTP_USER");
    private static final String SMTP_PASS = getEnv("SMTP_PASS");

    private static String getEnv(String key) {
        String value = System.getenv(key);
        if (value == null || value.isEmpty()) {
            value = dotenv.get(key);
        }
        return value;
    }

    public static void sendPayslipNotification(Employee emp, Payroll payroll) {
        if (SMTP_USER == null || SMTP_PASS == null || emp.getEmail() == null) {
            System.err.println("[EmailService] SMTP credentials or employee email missing. Skipping email.");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_USER, SMTP_PASS);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_USER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emp.getEmail()));
            String monthYear = new SimpleDateFormat("MMMM yyyy").format(payroll.getPayDate());
            message.setSubject("Payslip for " + monthYear);

            String htmlBody = "<h2>Hello " + emp.getName() + ",</h2>"
                    + "<p>Your payslip for the month of <strong>" + monthYear + "</strong> has been generated.</p>"
                    + "<ul>"
                    + "<li>Basic Salary: &#8377;" + String.format("%.2f", payroll.getBasicSalary()) + "</li>"
                    + "<li>Gross Salary: &#8377;" + String.format("%.2f", payroll.getGrossSalary()) + "</li>"
                    + "<li>Total Deductions: &#8377;" + String.format("%.2f", payroll.getTotalDeductions()) + "</li>"
                    + "<li><strong>Net Payable: &#8377;" + String.format("%.2f", payroll.getNetSalary()) + "</strong></li>"
                    + "</ul>"
                    + "<p>Please find your detailed Payslip PDF attached to this email.</p>"
                    + "<br><p>Best Regards,<br>HR Team - PayPulse</p>";

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(htmlBody, "text/html; charset=UTF-8");

            MimeBodyPart pdfPart = new MimeBodyPart();
            byte[] pdfBytes = PdfGenerator.generatePayslipPdf(emp, payroll);
            jakarta.mail.util.ByteArrayDataSource bds = new jakarta.mail.util.ByteArrayDataSource(pdfBytes, "application/pdf");
            pdfPart.setDataHandler(new jakarta.activation.DataHandler(bds));
            String fileNameMonthYear = new SimpleDateFormat("MMM_yyyy").format(payroll.getPayDate());
            pdfPart.setFileName("Payslip_" + fileNameMonthYear + ".pdf");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(pdfPart);

            message.setContent(multipart);

            Transport.send(message);
            System.out.println("[EmailService] Payslip email sent successfully with PDF to: " + emp.getEmail());

        } catch (MessagingException e) {
            System.err.println("[EmailService] Error sending email: " + e.getMessage());
        }
    }
}
