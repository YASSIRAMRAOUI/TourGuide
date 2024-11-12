package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Tour Guide Management System</title>\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css\" rel=\"stylesheet\">\n");
      out.write("</head>\n");
      out.write("<body class=\"flex flex-col h-screen bg-gray-100 font-sans\">\n");
      out.write("\n");
      out.write("    <!-- Header Section with Logo and Language Switch -->\n");
      out.write("    <header class=\"w-full bg-gradient-to-r from-blue-600 to-green-600 text-white text-center py-4 flex-shrink-0\">\n");
      out.write("        <div class=\"flex items-center justify-between mx-6\">\n");
      out.write("            <!-- Logo and Title -->\n");
      out.write("            <div class=\"flex items-center space-x-4\">\n");
      out.write("                ");
      out.write("\n");
      out.write("                <h1 class=\"text-4xl font-bold\">Tour Guide Management System</h1>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Language Switch Icons -->\n");
      out.write("            <div class=\"flex space-x-4\">\n");
      out.write("                <!-- English Flag -->\n");
      out.write("                <a href=\"ChangeLanguageServlet?lang=en\" title=\"English\" class=\"hover:opacity-75\">\n");
      out.write("                    en\n");
      out.write("                </a>\n");
      out.write("                <!-- Spanish Flag -->\n");
      out.write("                <a href=\"ChangeLanguageServlet?lang=es\" title=\"EspaÃ±ol\" class=\"hover:opacity-75\">\n");
      out.write("                    es\n");
      out.write("                </a>\n");
      out.write("                <!-- French Flag -->\n");
      out.write("                <a href=\"ChangeLanguageServlet?lang=fr\" title=\"FranÃ§ais\" class=\"hover:opacity-75\">\n");
      out.write("                    fr\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <p class=\"text-gray-100 mt-2\">Connecting tourists with experienced guides for unforgettable journeys.</p>\n");
      out.write("    </header>\n");
      out.write("\n");
      out.write("    <!-- Main Content Section with Image -->\n");
      out.write("    <div class=\"flex flex-1 items-center justify-center w-full\">\n");
      out.write("        <div class=\"flex flex-col items-center w-full max-w-3xl px-6 text-center animate-fadeIn\">\n");
      out.write("            <!-- Content Image -->\n");
      out.write("            <img src=\"assets/touriste.jpg\" alt=\"Tour Guide Image\" class=\"w-full h-64 object-cover rounded-lg shadow-lg mb-6 mx-auto max-w-md\">\n");
      out.write("            <h2 class=\"text-3xl font-semibold text-gray-800 mb-4\">Welcome to Our Tour Guide Management System</h2>\n");
      out.write("            <p class=\"text-gray-600 mb-8 leading-relaxed\">\n");
      out.write("                Explore new destinations and experiences with our platform. Whether you're a tourist looking to discover unique places or a guide aiming to share your knowledge,\n");
      out.write("                our system connects you to the best opportunities. Make reservations, plan activities, and engage with other travelers and guides in one seamless experience.\n");
      out.write("            </p>\n");
      out.write("\n");
      out.write("            <!-- Navigation Buttons with Hover Animation -->\n");
      out.write("            <div class=\"space-x-6\">\n");
      out.write("                <a href=\"login.jsp\" class=\"inline-block px-8 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-500 transform hover:scale-105 transition duration-200\">Login</a>\n");
      out.write("                <a href=\"register.jsp\" class=\"inline-block px-8 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-500 transform hover:scale-105 transition duration-200\">Register</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Footer Section -->\n");
      out.write("    <footer class=\"w-full bg-gray-900 text-white text-center py-4 flex-shrink-0\">\n");
      out.write("        <p class=\"text-sm\">&copy; 2024 Tour Guide Management System - All Rights Reserved</p>\n");
      out.write("    </footer>\n");
      out.write("\n");
      out.write("    <!-- Custom Animations -->\n");
      out.write("    <style>\n");
      out.write("        @keyframes fadeIn {\n");
      out.write("            from { opacity: 0; }\n");
      out.write("            to { opacity: 1; }\n");
      out.write("        }\n");
      out.write("        .animate-fadeIn {\n");
      out.write("            animation: fadeIn 1.5s ease-out forwards;\n");
      out.write("        }\n");
      out.write("        @keyframes spinSlow {\n");
      out.write("            from { transform: rotate(0deg); }\n");
      out.write("            to { transform: rotate(360deg); }\n");
      out.write("        }\n");
      out.write("        .animate-spin-slow {\n");
      out.write("            animation: spinSlow 20s linear infinite;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
