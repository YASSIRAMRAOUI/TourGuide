package controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.util.Properties;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final String SENDER_EMAIL = "yassiramraoui@gmail.com";
    private static final String SENDER_PASSWORD = "urjg keyn zqnz yhhj";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Email content
        String subject = "New Contact Form Submission from " + name;
        String emailMessage = String.format(
            "You have received a new message:\n\nName: %s\nEmail: %s\nMessage: %s",
            name, email, message
        );

        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            // Create a MimeMessage
            Message mailMessage = new MimeMessage(session);
            mailMessage.setFrom(new InternetAddress(SENDER_EMAIL));
            mailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SENDER_EMAIL)); // Send to your email
            mailMessage.setSubject(subject);
            mailMessage.setText(emailMessage);

            // Send email
            Transport.send(mailMessage);

            // Redirect with success message
            request.setAttribute("message", "Your message has been sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to send your message. Please try again later.");
        }

        request.getRequestDispatcher("includes/contact.jsp").forward(request, response);
    }
}

