/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/main/webapp/**/*.jsp",
    "./src/main/webapp/**/*.html",
    "./src/main/webapp/**/*.js",
  ],
  darkMode: "class", // Enable dark mode using a class
  theme: {
    extend: {
      colors: {
        primary: "#1DA1F2",
        secondary: "#14171A",
        // Add other colors as needed
      },
      fontFamily: {
        sans: ["Inter", "sans-serif"],
        serif: ["Merriweather", "serif"],
      },
    },
  },
  plugins: [],
};
